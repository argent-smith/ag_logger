(** The logging facility *)


module Config = Config
module Cli = Cli

(** Basic logging function type *)
type 'a log = ('a, unit) Logs.msgf -> unit Lwt.t

(** Generated logger module type *)
module type LOG = sig
  val debug : 'a log
  val info  : 'a log
  val warn  : 'a log
  val err   : 'a log
  val app   : 'a log
end

(** Sets up application-wide logging *)
val setup : Config.t -> unit

(** Creates logger module for specified source *)
val create : source:Logs.src -> (module LOG)

(** Cli options function to be used in toplevel Cmdliner setup *)
val opts : unit -> Config.t Cmdliner.Term.t
[@@deprecated "Use Ag_logger.Cli.opts instead"]
