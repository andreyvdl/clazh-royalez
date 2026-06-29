# Clazh Royalez

Clazh Royalez is a Zig wrapper around the Clash Royale API.  
Now you can create tools using the API in Zig without having to worry with
the json decoding.

⚠️ The Clash Royale API is one of the worst ever created, so expect some kind
of failure. ⚠️

## How to use

1. Instanciate a `ClazhAPI` variable.
2. Call `ClazhAPI.init` giving it an allocator (GPA type, don't use Arena type), a Io and your token.
3. Call the desired route.
4. Sucess.

For examples look the tests at `src/root.zig`.
