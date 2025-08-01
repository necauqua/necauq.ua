+++
title = 'TPN Script Reference'
build.list = 'never'
+++

# TPN Script Reference

TPN script is a "scripting language" of sorts that I am using in my Twitch
chat.

<!--more-->

> [!note]
> This syntax was initially devised for
> [Twitch Plays Noita](../posts/twitch-plays-noita), so the following reference
> will use things like pressing keys and mouse movement in examples.

## Command structure

A single simple command looks like this:
```tpn
any text command~ any other text
```

A command that accepts arguments can look like this:
```tpn
some more text here too command:arg1:arg2~
```

The standard format for commands is a `~` suffix. Historically, this has
happened because I "didn't want to be like the rest". Almost immediately, a `+`
prefix was also introduced for mobile users, and there was this whole thing
about collecting statistics on which version was used more, but that idea was
eventually scrapped.

A bit later, the _lenient_ command parser was introduced, which basically
allows most typical symbols to be command prefixes.

Here's a list of acceptable syntaxes, there's no difference between them:
- `kawaii~` - the initial one
- `+crusader` - the anti-weeb one
- `~prefix` - because people sometimes forgot ¯\\\_(ツ)_/¯
- `!normie` - to pretend to be any other bot
- `?question-mark` - I've seen some bots use that..
- `#hashtag` - ..and that
- `silent:arg1` - if there's at least one argument, meaning `:` is present, you
  can just drop the symbol altogether actually.

Another small quirk is commands of the form `command123~` would first try to
run a command or macro named `command123`, but if neither exist it would also
try `command:123~`, making the number into a first argument.

This is a shorthand to avoid typing `:` as commands having a single numerical
argument were quite common in TPN.

## Sequential commands
So commands can occur anywhere in the message and use this weird argument
syntax for a reason: a message can have multiple commands, they will be
executed one after the other, in parallel with all other messages(!).

This matters because certain commands take some time to execute, an obvious
example being `wait~`, which does nothing for 500ms.

As an example, you can do this:
```tpn
left~ wait~ wait~ right~
```

Which will hold the <kbd>a</kbd> button for 500ms (the default), wait for a
second and then hold <kbd>d</kbd> for another 500ms.

## Parallel commands
What if you want to hold the <kbd>d</kbd> key and tap the <kbd>w</kbd> key at
the same time to levitate? Or to climb an obstacle? Run and shoot?

All command sequences separated with a `|` symbol start and execute in
parallel.\
The `/` symbol would also work, it was added for mobile users.

So tap-levitating while moving to the right could look something like this
(note that I haven't tested those particular timings):

```tpn
up:100~ wait:400~ up:100~ wait:400~ up:100~ wait:400~ | right~ right~ right~
```

> [!note]
> As a general rule, commands that need or can wait for a variable amount of
> time, so holding down keys, `wait~` etc, accept an optional argument for the
> number of milliseconds with default usually being 500.

Commands after the `|` start executing immediately, in parallel with the
commands before it - so in this example you press <kbd>d</kbd> for 1.5 seconds,
while tapping <kbd>w</kbd> 3 times every 0.5 seconds for 0.1 seconds each.

You can have any number of commands and any number of parallel commands, the
only limit is the 500-character Twitch limit.

## Advanced
Scope creep happened, and during TPN I added countless requested features,
starting with macros and loops and ending with variable substitution and math.

> [!note]
> In the following examples I use `echo` excessively, but in my twitch chat
> `echo` is something only mods can use because it straight up makes the bot
> say whatever you give it, with _no_ indication that it's in response to
> your echo commands.
>
> You can replace any echo invocation with something like
> `let:x:"whatever" get:x` if you want to debug things or something.
>
> I need to add a viewer-available debug print command, or make a global
> macro for that let-get thing I just suggested at least..

All command parameters are strings. You can do something like

```tpn
repeat:10:" echo:\"hello world\" "
```

and as you can see, the `repeat` command _evaluates_ the string given to it in
the second parameter, calling any commands contained within N times.

Another thing you can see, is that nested strings require those ugly escapes
(`\"`) for it to work properly.

### Brace syntax
So another string syntax exists, this time using balanced braces:
```tpn
repeat:10:{ echo:{ hello world } }
```

Two important points:
- The second argument given to repeat is _still just a string_.
- Brace strings are _trimmed_, that is, `{ hello }` is equivalent to
  `"hello"`, not `" hello "`.

### Variable substitution
You can set persistent personal variables using the `set` command, or temporary
ones only visible inside of the current message with the `let` command.

There are a couple more variable manipulation commands in the full list below.

In any string, if you have a bit that looks like `%name`, it would be replaced
by the contents of that variable - or by nothing if the variable was not set.

```tpn
for example,
let:test:necauqua echo:{ Hello, %name! }~
```

Repeats and loops expose a variable named `i` to the script they're evaluating:
```tpn
repeat:10:{ echo:{ countdown %i } }
```

Macros expose the arguments _they are given when called_ as numbered variables:
```tpn
macro-record:test:{ echo:{ hello, %1 } } test:world
```

There is also a syntax for default values in case the variable does not exist:
```tpn
echo:{ Hello, %(name:stranger)! }
```
The default value (`stranger`) in this case, also gets variable expansion,
recursively:
```tpn
echo:{ Hello, %(1:%(default-name:stranger)) }
```
That last example first tries to use the variable `1` (first macro argument),
then the variable `default-name` and then defaults to `stranger`.

### Math expressions
There is actually a third string syntax, this time using parenthesis:
```tpn
echo:(2 + 2 * 2) <- this will print 6
```

This syntax forces the given expression to be evaluated as if the command
expected a number, which means it would be coersed to a number (which includes
passing it through a simple calculator) if possible, and error otherwise.

This works exceedingly well with string substitution:
```tpn
repeat:10:{ let:double:(%i * 2) echo:%double }
```

For example to make an increasing counter:
```tpn
macro-record:count:{ set:counter:(%(counter:0) + 1) echo:{ counted %counter times } }
count~
count~
count~
```

### Syntax debug
Using the exact same code that the bot uses to parse commands (thanks to WASM),
I made a small website that parses commands and shows you which of them and in
which order with what substitutions the bot will see.

The site has _no knowledge_ of any existing commands, it just checks the
syntax, and if a string parameter _looks like_ it contains commands, it will be
parsed out and shown in a tree, its quite neat.
 
Play with it at https://uq.rs/lexer - hosted on my other server that's not in
Ukraine like this site, because Ukraine blocks traffic from one particular
country _for free_, I appreciate the feature, but some people have had the
critical lack of luck to be born there sadly.

## The list of all commands

This is is auto-generated, so it is up to date, there are no hidden commands or
parameters 😉

> [!note]
> As of right now, this list still includes TPN-specific commands, notably ones
> for controlling Noita or OBS.
>
> Such commands are obviously **disabled** and would do nothing, at least until
> I run TPN 2.0 in a year or so.

The question mark after the argument name means that it is optional.\
Shortcodes are alternative short names for certain commands.\
The >= thingie means that the command requires that permission level or above.
{{< tpn-commands >}}
