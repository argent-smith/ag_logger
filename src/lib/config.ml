(** Logger configuration record *)
type t = {
    log_times   : bool;             (** Whether to add timestamps to the logs *)
    log_process : bool;             (** Whether to add process info to the logs *)
    verbosity   : Logs.level option (** Minimal log level (default: Logs.Info) *)
  }
