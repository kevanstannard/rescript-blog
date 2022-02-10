---
title: Reflections on a ReScript project
date: 2022-02-10 11:54:56
---

Over the past year I've rewritten a personal project from scratch to gain a deeper understanding of ReScript. The project has gone live today, and I'm hoping it might be helpful to share a reflection of my experience.

The project has over 500 ReScript files and just under 50,000 lines of ReScript code. It's a NextJS project, with both server side and client side written in ReScript.

## Starter Template

Thanks to @ryyppy for making the [ReScript NextJs Template](https://github.com/ryyppy/rescript-nextjs-template) available. I was able to get up and running very quickly with this template.

## ReScript Language

Coming from a JS/Flow/TypeScript background, it was comfortable it was to write most of the ReScript syntax. I would sometimes just use JS syntax and it often just worked. The VSCode ReScript plugin auto fixing syntax was also helpful.

In the beginning I was skeptical of how type safe the language was. However, after a year of ReScript I've gained full confidence in the type system. Refactoring is enjoyable. I've learned that TypeScript is no comparison in type safety compared to ReScript.

Comments on some other language features:

Targeting a subset of the JS language was nice, and made learning ReScript simpler.

[Variants](https://rescript-lang.org/docs/manual/latest/variant) are a great language construct and allows a nice way to express certain types (particularly compared to TypeScript).

Learning about which [utility libraries](https://rescript-lang.org/docs/manual/latest/api) to use (Belt, Js, Array2, String2, etc.) was a bit confusing at first but I know the team have improvements planned here.

Learning some of the language idioms such as `Response.getStatus(response)` compared to `response.status` was different, but not difficult to adopt.

## ReScript React

ReScript React support is amazing. For me it was a mostly easy learning curve. Syntax is very close to regular JSX in JS and was easy to be productive quickly.

Learning how to use DOM events took a bit of investigation, but the pattern is simple once you know it. I've seen on the forum some concerns about type safety with events due to using open objects, e.g.

```res
let value: string = ReactEvent.Form.target(event)["value"] // Unsafe
```

I felt that type safety risk was low in cases like this one, so was not concerned with this approach. 

## ReScript Compiler

The compiler is very fast. This project now compiles in about 20 seconds (500+ ReScript files), and after that it feels instant.

I struggled with debugging type issues from time to time, but I suspect this is mostly due to my inexperience with the type system, and with some perserverance I managed to work things out.

## ReScript Bindings Syntax

I learned that understanding the binding syntax was important, so I dedicated time to learning it. Now I feel it's mostly straightforward.

My biggest learning here was to only write the bindings for functions that I actually needed. Typically I needed very few functions from a library, and only some specific use cases. So I'd only write bindings for just those few - this was very productive strategy.

## Compiled JS

The compiled JS is amazingly clean and generally easy to read (after formatting), which was essential when debugging.

## MongoDb

I used MongoDb for the project. It was nice to work with since it deals with objects that potentially match nicely with ReScript Records.

The main challenge here was dealing with `null` and `undefined` values for some fields. I was alternating between using `Js.Null.t`, or `Js.Undefined.t`, or `Js.Nullable.t`, or using `option` types.

When returning values from the database, I was undecided if I should return `{..}` or `Js.Json.t`, so I ended up having a mix of those.

Not a ReScript specific issue, but something that I encountered when trying to achieve type safety.

## NextJS

This was my first NextJS project. Thanks to the template, all of the initial setup problems were resolved.

It was also nice to be able to share types on both the client and server side.

I only faced one regular challenge. In NextJS, code sent from the server to the client must be valid JSON which disallows `undefined` values. This meant that all `option` types needed to be converted to `Js.Nullable.t` types, and then decoded back to `option` again on the client. From time to time I would forget this and get errors.

Not a ReScript specific issue, but something that needed some special handling.

## Writing Encoders and Decoders

This was the most challenging aspect of the project.

This is not a ReScript specific issue, but rather a challenge with interacting with systems external to ReScript.

This included decoding MongoDb objects into server side Records, encoding server side Records into into DTO objects to send to the client, decoding those on the client into client side Records. I had multiple representations of essentially the same data.

I started with [ReScript's JSON functions](https://rescript-lang.org/docs/manual/latest/api/js/json), switched to [bs-json](https://github.com/glennsl/bs-json), switched to [decco](https://github.com/reasonml-labs/decco), but eventually settled on [rescript-jzon](https://github.com/nkrkv/jzon).

Other than using Jzon, at times I specifically used Record types that could be also be used directly as JSON objects without any encoding/decoding - particularly as DTOs between client and server, so I made quite a lot of use of:

```res
external asJson: 'a => Js.Json.t = "%identity"
external asMyOtherType: Js.Json.t => myOtherType = "%identity"
```

This trades type safety for time saved writing many encoders and decoders.

## Code Structure

It took a few attempts to find a nice code structure. For this project I settled on:

```
bindings/SomeLib.res

components/Component_SomeComponent.res

layouts/Layout_SomeLayout.res

modules/client/Client_SomeClientModule.res
modules/common/Common_SomeCommonModule.res
modules/server/Server_SomeServerModule.res

pages/Page_SomePage_Server.res
pages/Page_SomePage_Types.res
pages/Page_SomePage_View.res
pages/Page_SomePage.res
```

This was influenced by it being a NextJS project. I imagine I might use a different structure for a non-NextJS project.

## VSCode ReScript Plugin

The plugin is exceptional. Auto formatting, auto fixing, syntax highlighting, syntax prompts and great responsiveness made overall development a great experience.

One feature of automatically pre-filling some syntax with a template, such as a `switch` statement, was not useful for me personally and I found myself regularly deleting the template code and writing what I actually wanted, but only a minor inconvenience.

## ReScript Community

Amazing community on the forum, very helpful and friendly to newcomers. Many very experienced developers are there regularly providing their time and support.

## ReScript Project

I just wanted to share only one concern - it appears that only two members of the seven member ReScript team participate in the forum, and the success of ReScript project appears to depend on those people. This is the only concern I have with advocating for ReScript on commercial projects, but I'm hopeful this is something the team can address in time.

## Final Thoughts

I'm grateful to @Hongbo and the rest of the team for the enormous effort put into this project over many years.

It's unique in the JS dev space. There are other compile to JS languages, but none that cater directly to JS devs, as far as I'm aware.

So in the meantime, I'll do what I can to help contribute to the project from time to time.

Lastly; a reflection of how I feel when working on JS vs TypeScript vs ReScript projects:

![JavaScript vs TypeScript vs ReScript](static/js-ts-res.jpeg)

## The Project

Live project is here:

[https://www.pixelpapercraft.com](https://www.pixelpapercraft.com/)

An open source part of the project is here:

[https://github.com/pixelpapercraft/pixel-papercraft-generator-builder](https://github.com/pixelpapercraft/pixel-papercraft-generator-builder)

