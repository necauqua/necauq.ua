+++
title = 'Twitch Plays Noita'
date = '2025-04-06'
tags = ['noita', 'twitch']
+++

So I am finally launching Twitch Plays Noita.
I thought it would take like a week or two, but it took upwards of ~four~
~five~ six 😅.

Mostly because of my typical issues with perfecting little inconsequential
things ¯\\\_(ツ)_/¯

The Twitch stream is/will be/was happening over at https://twitch.tv/necauqua
:)

Planned start date is Sunday, April 6, 2025, 16:00 EEST (8AM CT)

## Command structure
You can send commands in the Twitch chat to make inputs to the game.

Messages from a single Twitch account are only processed once per 0.5 seconds
in an attempt to slightly curtail spamming and botting, I might change that.

A command looks like this:
```tpn
any text command-name:arg1:arg2~ any other text, COGGERS
```

So for example you
can send `click~` to make a left mouse button click, or `slot:2~` to press the
<kbd>2</kbd> button on the keyboard - and you can do that in the middle of your
message!

> [!question] But why `~` at the end though?
>
> This is to make the chat feel a little bit more _kawaii~_
>
> If you are _strictly_ against having any relation to anything weeb, you can
> prefix the commands with `+` instead, so it will look like
> `+command-name:arg1:arg2`, much more _normal_, eww
> 
> Later we will be able to analyse the logs to see which version is used more
> and we will see who wins - weebs or, eeeehh.. crusaders?. (cuz of the plus)
> punchers?. cringe normies?.. whatever you call those people

## Sequential commands
So commands can occur anywhere in the message and use this weird syntax for a
reason: a message can have multiple commands, they will be executed one after
the other, in parallel with all other messages(!).

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
parallel.

So tap-levitating while moving to the right could look something like this
(note that I haven't tested those particular timings):

```tpn
up:100~ wait:400~ up:100~ wait:400~ up:100~ wait:400~ | right~ right~ right~
```

> [!note]
> As a general rule, commands that need or can wait for a variable amount of
> time, so holding down keys, `wait~` etc, accept an optional argument for the
> number of milliseconds with default (and maximum) usually being 500.

Commands after the `|` start executing immediately, in parallel with the
commands before it - so in this example you press <kbd>d</kbd> for 1.5 seconds,
while tapping <kbd>w</kbd> 3 times every 0.5 seconds for 0.1 seconds each.

You can have any number of commands and any number of parallel commands, the
only limit is the 500-character Twitch limit.

## The list of all commands

This is is auto-generated, so it is up to date, there are no hidden commands or
parameters 😉

You can also view the it separately [here](../../tpn).

The question mark after the argument name means that it is optional.

{{< tpn-commands >}}
