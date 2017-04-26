# Recollect
A simple tool for creating, managing, and viewing snippets, notes, or pretty much any other text-based content at the command line. The original purpose was to store infrequently used complex command strings in a location where they could easily be indexed and retrieved.

*Note* If you find yourself outlining complex procedures, you should consider if a shared team knowledge base might be a better fit.

### Installation

    gem install recollect

If you haven't already, you should set your EDITOR. On OSX you can set it to Textmate with a command like:

    echo 'export EDITOR="mate -w" >> ~/.bash_profile

### Usage
USAGE: recollect ACTION [arg]
  Actions: list, new, edit, or <name> where <name> is the recollection to be displayed.
    list        - provides a listing of all available recollections
    name        - displays the recollection matching 'name'
    new [name]  - provides a listing of all available recollections
    edit [name] - provides a listing of all available recollections
    remove [name]   - removes a recollections
Note: ["new", "edit", "remove", "help"] are reserved and cannot be the name of a recollection.
