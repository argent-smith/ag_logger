[![argent-smith](https://circleci.com/gh/argent-smith/ag_logger.svg?style=shield)](https://circleci.com/gh/argent-smith/ag_logger)

# Ag_logger

Custom Lwt logger with process/time based on [Logs](https://github.com/dbuenzli/logs)
by [Daniel Bünzli](https://github.com/dbuenzli).

## Differences from the original Logs library

* `Logs.Info` is the default loglevel
* `-v` CLI option removed
* Added CLI options for process info and times logging

## Usage example

See `examples/loggee.ml`

Commands to build the example:

```shell
$ cd ag_logger
$ dune build examples/loggee.exe
$ dune exec examples/loggee.exe -- --help
$ dune exec examples/loggee.exe -- -q
$ dune exec examples/loggee.exe -- --verbosity=debug -P -T
```

## Cli options implemented

The library contains Cmdliner code implementing these options:

*  `-P`, `--log-process` (absent `LOG_PROCESS` env)
      Whether to add process info (name & pid) to log messages.

*  `-T`, `--log-times` (absent `LOG_TIMES` env)
      Whether to timestamp log messages.

*  `-q`, `--quiet`
      Be quiet. Takes over `--verbosity`.

*  `--verbosity=LEVEL` (absent=`info` or `LOG_VERBOSITY` env)
      Be more or less verbose. LEVEL must be one of `quiet`, `error`,
      `warning`, `info` or `debug`.

## License

[MIT](LICENSE), with respect to the original work/license by
[Daniel Bünzli](https://github.com/dbuenzli) et al.

## Contributing

Feel free to clone/contribute/issue this pile of code.
