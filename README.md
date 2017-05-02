# Recollect
A simple tool for creating, managing, and viewing snippets, notes, or pretty much any other text-based content at the command line. The original purpose was to store infrequently used complex command strings in a location where they could easily be indexed and retrieved. Text files are stored under `~/.recollections` and can be accessed using other tools or methods (e.g. Git, Dropbox, etc).

*Note* If you find yourself outlining complex procedures, you should consider if a shared team knowledge base might be a better fit.

### Installation

    gem install recollect


### Search Functions
Recollect includes both a `search` directive and a recollection matching capability.

The search capability looks inside of files for a specific search string using a line match (`=~ /string/`).

The recollection match will try to find similar recollection names when showing a recollection or when using edit, remove, or append. When only one match is found the user is prompted to confirm this is the recollection intended; on confirmation the requested action will be executed. When multiple matches are found they will be displayed as suggestions.

### Usage

    USAGE: recollect ACTION [arg]
    Recollect manages a series of things worth remembering "recollections" as a series of
    text files.

      Actions: list, new, edit, or <name> where <name> is the recollection to be displayed.
        list [category] - provides a listing of all available recollections.
                          use [category] to specify a subdirectory
        name            - displays the recollection matching 'name'
        new <name>      - creates a new recollection
        edit <name>     - modifies an existing recollection
        remove <name>   - removes a recollection
        search <searchstr>  - searches all recollections for "searchstr"
        append <name> <str> - appends <str> to the existing recollection <name>

    Note: ["new", "edit", "remove", "help", "search", "append"] are reserved and cannot be the name
    of a recollection.

    Version: 0.1.0

### Examples

If you haven't already, you should set your EDITOR. On OSX you can set it to Textmate with a command like:

    echo 'export EDITOR="mate -w" >> ~/.bash_profile

##### Create a new recollection named git
    recollect new git   # edit, save, and close the editor
    
##### List the available recollections
    recollect list

##### List the available recollections under mysql/
    recollect list mysql
    
##### Edit the git recollection
    recollect edit git  # edit, save, and close the editor
    
##### Display the git recollection
    recollect git
    
##### Search for recollections containing 'postgres'
    recollect search 'postgres'
    
##### Find with a partial recollection name
    recollect ra
    
    > **** Unable to find a recollection matching 'ra'
    > You might have meant:
    >   raid
    >   rails
    >   unicorn/rack
    