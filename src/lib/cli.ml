open Base
open Cmdliner

let strf = Caml.Format.asprintf
and join = Option.join
and value = Option.value
and find = List.Assoc.find

let level ?env ?docs ?default:(default_level = "info") () =
  let enum =
    [ default_level, None;
      "quiet", Some None;
      "error", Some (Some Logs.Error);
      "warning", Some (Some Logs.Warning);
      "info", Some (Some Logs.Info);
      "debug", Some (Some Logs.Debug); ]
  in
  let enum_tail = List.(tl enum |> value ~default:[]) in
  let verbosity =
    let log_level = Arg.enum enum in
    let enum_alts = Arg.doc_alts_enum enum_tail in
    let doc = strf "Be more or less verbose. $(docv) must be %s." enum_alts
    in
    Arg.(value & opt log_level None &
         info ["verbosity"] ?env ~docv:"LEVEL" ~doc ?docs)
  in
  let quiet =
    let doc = "Be quiet. Takes over $(b,--verbosity)." in
    Arg.(value & flag & info ["q"; "quiet"] ~doc ?docs)
  in
  let choose quiet verbosity =
    if quiet then None else match verbosity with
    | Some verbosity -> verbosity
    | None -> find enum_tail String.equal default_level
              |> join
              |> join
  in
  Term.(const choose $ quiet $ verbosity)

  let docs = "LOGGING OPTIONS"

  let log_times =
    let doc = Arg.(info ~docs
                        ~doc:"Whether to timestamp log messages."
                        ~env:(env_var "LOG_TIMES")
                        ["log-times"; "T"]) in
    Arg.(value @@ flag doc)

  let log_process =
    let doc = Arg.(info ~docs
                        ~env:(env_var "LOG_PROCESS")
                        ~doc:"Whether to add process info (name & pid) to log messages."
                        ["log-process"; "P"]) in
    Arg.(value @@ flag doc)

  let verbosity = level ~env:(Arg.env_var "LOG_VERBOSITY") ()

  let opts () =
    let combine log_times log_process verbosity =
      Config.({ log_times; log_process; verbosity })
    in
    Term.(const combine $ log_times $ log_process $ verbosity)
