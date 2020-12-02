(** Ag_loger CLI terms *)

val level :
  ?env:Cmdliner.Arg.env ->
  ?docs:string ->
  ?default:string -> unit -> Logs.level option Cmdliner.Term.t
(** Implements the following cli options support:
    {ul
    {- [-q], [--quiet]: Be quiet. Takes over [--verbosity].}
    {- [--verbosity=LEVEL] (absent=[info] or [LOG_VERBOSITY] env):
        Be more or less verbose. LEVEL must be one of [quiet], [error],
        [warning], [info] or [debug].}
    }
*)

val log_times : bool Cmdliner.Term.t
(** Cmdliner term implementing logging option
    {ul
    {- [-T], [--log-times] (absent [LOG_TIMES] env)
           Whether to timestamp log messages.}
    }
*)

val log_process : bool Cmdliner.Term.t
(** Cmdliner term implementing logging option
    {ul
    {- [-P], [--log-process] (absent [LOG_PROCESS] env)
           Whether to add process info (name & pid) to log messages.}
    }
*)

val verbosity : Logs.level option Cmdliner.Term.t
(** Cmdliner term wrapping [level] function;
    adding [LOG_VERBOSITY variable support]
*)


val opts : unit -> Config.t Cmdliner.Term.t
(** Cli options function to be used in toplevel Cmdliner setup *)
