#!/usr/bin/env python3

from pathlib import Path
from os import listdir

from pyAttributes.ArgParseAttributes import (
    ArgParseMixin,
    ArgumentAttribute,
    Attribute,
    CommandAttribute,
    CommonSwitchArgumentAttribute,
    DefaultAttribute,
    SwitchArgumentAttribute
)

from HardwareStudioServer import HardwareStudioServer


class Tool():
    HeadLine = "Hardware Studio CLI tool"

    def __init__(self):
        pass

    def PrintHeadline(self):
      print("{line}".format(line="="*80))
      print("{headline: ^80s}".format(headline=self.HeadLine))
      print("{line}".format(line="="*80))

    @staticmethod
    def serve(dist, addr, port):
        hws = HardwareStudioServer(dist)
        hws.run(host=addr, port=port)


class WithBuildAttributes(Attribute):
  def __call__(self, func):
    self._AppendAttribute(func, SwitchArgumentAttribute("--dry-run", dest="dry_run", help="Print build commands but do not execute them."))
    # ... add more if needed
    return func


class CLI(Tool, ArgParseMixin):
    def __init__(self):
        import argparse
        import textwrap
        # Call constructor of the main inheritance tree
        super().__init__()
        # Call constructor of the ArgParseMixin
        ArgParseMixin.__init__(
          self,
          description=textwrap.dedent('Flask backend and CLI API to handle simulation/implementation tools.'),
          epilog=textwrap.fill("Happy hacking!"),
          formatter_class=argparse.RawDescriptionHelpFormatter,
          add_help=False
        )

    # @CommonSwitchArgumentAttribute("-q", "--quiet",   dest="quiet",   help="Reduce messages to a minimum.")
    # @CommonSwitchArgumentAttribute("-v", "--verbose", dest="verbose", help="Print out detailed messages.")
    # @CommonSwitchArgumentAttribute("-d", "--debug",   dest="debug",   help="Enable debug mode.")
    def Run(self):
        ArgParseMixin.Run(self)

    @DefaultAttribute()
    def HandleDefault(self, args):
        self.PrintHeadline()
        self.MainParser.print_help()

    @CommandAttribute("help", help="Display help page(s) for the given command name.")
    @ArgumentAttribute(metavar="<Command>", dest="Command", type=str, nargs="?", help="Print help page(s) for a command.")
    def HandleHelp(self, args):
        if (args.Command == "help"):
            print("This is a recursion ...")
            return
        if (args.Command is None):
            self.PrintHeadline()
            self.MainParser.print_help()
        else:
            try:
                self.PrintHeadline()
                self.SubParsers[args.Command].print_help()
            except KeyError:
                print("Command {0} is unknown.".format(args.Command))

    @CommandAttribute("serve", help="Start a Flask web server.")
    @ArgumentAttribute(
        "-d", "--dist", dest="dist", default=Path(__file__).parent.parent / "dist",
        help="Location of the base path to serve from."
    )
    @ArgumentAttribute(
        "-a", "--addr", dest="addr", default="0.0.0.0",
        help="IP address to listen at."
    )
    @ArgumentAttribute(
        "-p", "--port", dest="port", default="80",
        help="Port to listen at."
    )
    def HandleServe(self, args):
        self.serve(args.dist, args.addr, args.port)


if __name__ == "__main__":
    CLI().Run()
