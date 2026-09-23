+++
date = '2026-09-20T12:06:10+03:00'
title = 'Personal AI usage disclosure'
tags = ['dev', 'yapping', 'llm']
+++

> [!warning] Important
> Since people have strong opinions about it and in an effort to keep things
> honest, let me write it once here so I can link to it from relevant README
> files and be done with it:
> 
> ✨ I use LLMs when working on my projects. ✨
> 
> If you have problems with it, you have been informed.

This post is completely inspired by [that
one](https://dpc.pw/posts/personal-ai-usage-disclosure/) — in fact I did copy
the starting paragraph verbatim as it spoke to me ¯\\\_(ツ)_/¯ (had to google "em
dash" like a caveman to put it right here).

I agree with everything outlined there, 100% - so please read that, maybe after
finishing this, because my personal history with LLMs is of course different.

## My history of using LLMs

### A better search engine

In late spring of 2026, my LLM usage boiled down to using Claude (which I have
been paying for since 2025) as a ChatGPT replacement (which I have also paid for
before, but I cancelled and switched to Claude at some point because I'd heard
"it's better for coding") - just talking to it, asking for general programming
knowledge and documentation, how to do this and that, basically a way better
search engine, because SEO slop has ruined just googling stuff.

At most I've manually copied half a screen of code it made for me, like a single
function, that I then rigorously reread and maybe also completely rewrote, and
left a bunch of comments "yup this is megaslop, actually vibecoded this one, yes
yes, I stooped that low".

### Actually trying out a harness

Then my employer kindly asked me, "how much of those infinite Claude tokens we
recently started paying big boy money for are you using?" It's nothing too bad,
I do believe they were just looking into how much people are using/not using it
to measure impact, optimize costs and so on. They are not forcing anyone to burn
tokens or anything, my current employer seems more than fine in that regard
compared to some of the stories we've been hearing.

At the time, however, I kinda did believe I needed to burn some tokens to not
stand out from the crowd, so I actually tried using Claude Code then. I had
heard of harnesses before: basically you wire a model to do certain actions via
specially formatted tool calls. Instead of asking a slow and stupid human to read
relevant files, research, debug and experiment, it can just, like, do it
itself - you just have to run it through a program that allows it to. But I was
kind of paranoid and skeptical about hallucinations and whatnot, so initially I
did not really believe in the concept, despite Linus Torvalds himself saying he
vibecoded some side-project by "removing the human obstacle between the model
and the code", which in hindsight makes perfect sense actually.

So I forwarded some simple tasks to Claude Code and then neurotically reviewed
all the code it made. There was also this thing where I did not believe for some
reason that models are good at copying things - like if you have some very
specific string that needs to be refactored to another place, I did not believe
it would reliably correctly copy it byte-for-byte. So I was meticulously
checking every instance of that, mostly with Copilot, which I *have* been using
for years.

### The corruption

The thing is - everything it did (mind you, the tasks were simple) was flawless,
refactor - done, I don't like something, tell it to improve⁠/⁠fix⁠/⁠change it -
done, implement a simple endpoint - done. And I _see the reasoning_, the steps
it took; it asked for permission to run those little one-shot scripts LLMs do to
test, experiment, reliably refactor something, etc. In the case of the simple
endpoint, it _looked around_, saw other similar endpoints, and replicated the
shape, the logging, code style, naming, you name it. And then the tests. Boy do
I never write tests, at most I can maintain/extend an existing test suite - and
it wrote a bunch of them. Yeah, some of them kinda test nothing useful, but it's
**way better than nothing**!

And so, as I was _actually using_ the slop machine, not just seeing the absolute
and utter garbage that image generation AI is used for - and, believe it or not,
its output is not _incomprehensible_ to me, you know, years of programming
experience, decades at this point - I changed my mind.

To be clear, it is _painfully obviously_ not perfect, nothing is, hello, but
it's _good enough_ - often it is _better_ than whatever I would've done.

### Personal projects

Then there comes the productivity, boy, the productivity. At this point, I've
already started using [pi.dev](https://pi.dev/) for my personal projects, and
that particular harness is peculiar in that the first vibeco.. *cough-cough*
AI-assisted project you do with it is improving it. It is very minimal, but
quite hackable with TypeScript extensions, and the whole philosophy is that you
ask it to make those extensions to itself to better suit your particular
workflow.

We made a statusbar plugin that runs a little curl command I copied from
devtools to show me the usage limits. A tool that enforces a specific jj
commit format. A sandbox tool that fires up a podman container for those one-off
data processing scripts it makes, to not bother me with permission prompts. Oh
btw, you want to install a permission extension; by default pi comes with none,
meh.

Also after having a session you just ask it to add a point about something to
the global AGENTS.md file so it always remembers some preference of yours,
something you figured out you need to always make it do, etc etc.

I'll give you a couple of examples: "Always use a tool/code to perform any
mathematical calculation, no matter how trivial. You can use the `calc` command
for this.", "Always prefer to use `uv` when running Python or writing Python
scripts" etc.

### NixOS

And so after you get a workflow down, after you calm the paranoia down a bit,
you can.. just go at it. I have not made any major NixOS config changes in
months without the majority of it being Claude-generated.. and then reviewed,
prompted to fix/improve/rewrite/change stuff, then squashed it all down into a
neat jj commit. And the AGENTS.md of the nix config prompts it to try to build
the config after it's done, so if it sees issues it fixes those - at the end you
always get something that at least builds. Which is why writing Rust or
TypeScript is quite popular with LLMs, more automated guarantees earlier, kinda
like that.

The thing about tinkering with NixOS, or just working on personal hobby
programming projects in general, is that it takes time and energy to figure out
stuff, which I kind of lack as of late. With an LLM, you ask it "yo can this be
done" and after a bit of deliberation it will give you an answer that is
_significantly_ better than one you'd have gotten yourself after a day of
research. And it didn't just hallucinate it out of thin air, it can google stuff
itself. And most importantly, what they do now is ***test***. It will ***test***
its own claims before presenting them. It will look at _actual sources_ from
the nix store, be it nix modules or even literally the source code of the
service we're looking at. It will _run a temp setup real quick_ to check if the
suggested setup has any merit - and only then report its findings.

And then with all that juicy context already loaded, you just tell it to
implement it, give it the choices you make and let it go at it.

## Ghidra MCP

After installing Ghidra MCP and pointing Claude at it, I built a thing I utterly
would never have managed otherwise: a mod that improves the Noita replay editor,
so you can scrub the replay frame-by-frame, as well as export replays as mp4,
which is a way better format than gif. It works much faster too, since we
brought the real library in. Maybe I'll write a separate post about all that.

Some context: some of the people reading this might know I dabble in Noita
modding a little, in fact I made a whole framework that wraps around
TypeScriptToLua to be able to write Noita mods in TypeScript. It has a built-in
workaround for a certain `dofile` idiosyncrasy of how the Noita Lua API works,
and a bunch of nice autocompletions for things, which was the whole point of
making it in the first place, as well as many other utilities. I mostly made it
for myself, it also has a CLI that can start an isolated Noita instance
conveniently, build and publish the mod and so on.

And you can open Noita in Ghidra to look at the actual engine code - I'd argue
Noita is one of the easier things to disassemble and look at, good learning
experience. I have done so, annotated some stuff, found interesting bits and
bobs.

Like, it would be physically possible for me to make that project without
assistance, but the time and effort requirements would've been way past my
limits for what is basically a hobby, especially with my low energy and mood
reserves lately.

## Review & Research

One thing that is undeniably harmless is asking it to review anything you
wrote - yourself, no LLMs, big hater, sure. However, when doing some experiments
with DLL injection for Noita modding, I just asked it to check the things I was
doing, and it found countless bugs, holes, leaks and other actually embarrassing
things I was doing there. Like, it would point you at things *it thinks* are
important. And even if you're a huge skeptic - even one out of ten findings that
*you*, the person supposedly knowing what they're writing, completely missed,
sounds valuable to me.

That one I kinda agreed with even before this whole eye-opening experience
I've described above.

## Why it works

Unlike NFTs, large language models are unambiguously useful in a plethora of
applications. They have been a major boost to my productivity *and*
to my quality.

"But that means your quality was trash before them" - yes, I guess it means
that, woe is me. For my purposes, an increase is an increase ¯\\\_(ツ)_/¯

And I have something that people who use LLMs to code without knowing what
they're doing do not - I understand what they are writing, I have the critical
mass of knowledge (and opinions) where I learn from them and correct them, no
*actual vibecoding* here.

## Slop

All of that being said, there are two big things that are completely ruining the
perception of AI, ignoring all the IRL material costs (RAM prices, datacenters,
*water* for some reason, etc):

1. Generative AI - while it probably is still more useful than NFTs, 99 point
idk how many nines percent of generative AI is literal cancer. Yes yes artists
are crying, but also it's just slop slop slop slop, tiktok slop, meme slop, 3D
printing model slop, deepfake slop (ouch) and so much more.

2. Slop spam - people just.. misusing this amazing tool, to vibe-write reports,
vibe-spam, vibecode shit and push the burden of review on maintainers. If I make
a pull request with an LLM, I have a reason to, I am certain it does what it's
supposed to, etc etc. If the maintainer sees *any* clue of it being
"AI-assisted", they immediately close it, ban me and hate me forever because of
hundreds and thousands of spam PRs by slop kiddies ruining everything for
everyone.

## The genie

You've heard this argument before, but - the genie is out of the bottle, yes, yes,
they stole the internet, it is used for many stupid, malicious and slop
purposes.

Refusing to put it to good use for your benefit _does nothing_.

And it does not mean you're against somehow managing to get some justice for the
aforementioned stealing of the entire internet - would be nice if they got some
comeuppance, although that seems unlikely.

## Conclusion

You see a lot of people on the internet fully embracing the slop - usually for
social or financial gain. Pretending to be something you're not also seems to be
a thing, again literally either for social (ego boost?.) or financial gain
(literal scam).

Also you see a lot of people rejecting AI outright, and while it makes sense for
generative AI, for things like coding and some adjacent applications it is an
incredible tool, invaluable even. You know, large **language** models seem to be
good at this natural language thing, as well as coding languages.

And a lot of those opinions come from people who _I am certain_ are exactly
where I was before spring 2026 - they didn't truly use a good LLM with a harness
to work on personal projects, so they do not grasp how insanely good they've
actually gotten, and how you _can_, in fact, herd them. And they denounce any
project that used AI as "complete and utter slop garbage", equating it to the
slop-slop-slop-slop that (seemingly) most people are spamming.

Those are the two extremes, and both extremes are stupid.

Having experienced it properly, I am now in more of the AI-leaning moderate
group I feel like.

It is sad; I hope that, as time progresses, more people will see that LLMs for
coding actually have merit.

---

<small>
P.S.<br>
I did ask the clanker to proofread this, and we did: fix grammar, typos and
missing articles, split the history section into subsections (I titled them, it
suggested some slop), break up the six longest run-on sentences, halve the
<code>..</code> density, reduce the slop rant, and reorder sentences in the
Ghidra section and the conclusion.

This did help readability, and the whole rant is still entirely my own.
</small>
