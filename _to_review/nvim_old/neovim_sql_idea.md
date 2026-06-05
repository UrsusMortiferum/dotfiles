# Neovim Plugin for the DB-related activities

## Project plan:

1. Database Connectivity:
    * support for multiple DBs
    * autonomous or user-friendly driver management
    * connection management
1. Base Usage - Query Writing and Execution:
    * IntelliSense - Completion based on the tables/columns available in the connected database (perhaps way to limit results based on the used scheme)
    * Query Execution (function and predefined remap)
1. The good kids on the block:
    * LSP * Formatting * Linter
        * Formatting - user-friendly guide to tweak some elements
1. GUI-like experience:
    * Connection Management (pop-up window like telescope) with an option to:
        * select current connection (for the buffer?)
        * search for connection - grep
        * modify connection elements
        * create a connection
        * remove a connection
    * Database Schema Explore (pop-up windows displaying schemes, tables, etc.)
        * search option (for a specific table, column?)
    * Query Result Display
        * output as the bottom of the screen in a subwindow (predefined 10 rows + headers)
        * sorting? filtering?
    * Export options:
        * CSV
        * JSON
        * ?
1. Documentation and Support
    * User Guide?
    * Developer Guide?
    * Community Support?
1. Security and Compliance:
    * Connections
    * Credentials
    * Compliance?
1. Potentials:
    * <leader>c or <C-c> as a shortcut for the connection menu (choose, add, delete, etc.)
    * potential usage of the LuaSQL, instead of Lua itself
    * potential usage of Python?
    * drivers packaged v drivers on the request
    * option to specify tnsnames.ora file or another file for aliases per DB type
    * sql dictionary/help for functions, etc.
