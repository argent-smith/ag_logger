open Cmdliner

let info =
  let version = "%%VERSION%%"
  and doc = "Ag_logger example program" in
  Term.info "loggee" ~version ~doc

open Lwt
(* Logger module instatiantion *)
let source = Logs.Src.create "main process" ~doc:"Main process logging"
module Log = (val Ag_logger.create ~source : Ag_logger.LOG)

(* Logger CLI options instantiation *)
let logger_config = Ag_logger.Cli.opts ()

(* Logging function example *)
let main logger_config =
  Ag_logger.setup logger_config;
  let threads = [
    Log.err (fun f -> f "Error log message");
    Log.info (fun f -> f "Info log message");
    Log.warn (fun f -> f "Warning log message");
    Log.debug (fun f -> f "Debugging log message");
    Log.app (fun f -> f "Application log message");
  ] in
  join threads |> Lwt_main.run

let program = Term.(const main $ logger_config)

let () =
  match Term.eval (program, info) with
  | `Error _ -> exit 1
  | _ -> exit 0
