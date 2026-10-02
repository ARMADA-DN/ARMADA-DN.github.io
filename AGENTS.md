# AGENTS.md — ARMADA site

Static GitHub Pages website for the ARMADA doctoral network on reliable conversational data exploration, served at armada-dn.eu.

## Core rules

These are binding. They override any general default behaviour.

1. **Never touch anything outside this repository.** Not sibling repositories,
   not `$HOME` dotfiles, not system paths, not global installs. Reading outside
   it is not allowed either without asking first.
2. **Never `git commit` without explicit permission**, every time. "The change
   is finished" is not permission.
3. **Check the branch before starting; never switch without a yes.** If the
   work belongs on another branch or a new one, propose the switch and wait.
4. **Never stage in bulk.** No `git add -A`, `git add .`, `git add -u`,
   `git commit -a`. Enumerate paths.
5. **One commit per topic**, and every commit an agent authors ends its subject
   line with `[BOT]`. Never a commit called "update".
6. **`.temp/` is gitignored scratch space.** Read it, ask before writing, never
   overwrite without a named yes, never commit it, and never name its paths in a
   committed file.
7. **Size-check before reading any file.** A large generated file saturates the
   context window and blocks the user's work.
8. **Never start a long-running or destructive operation on your own
   initiative.** Describe the command and let the user run it.
9. **Ask instead of investigating, when asking is cheaper**, and be brief.

## Other instruction files

Coding agents keep their instructions in files of their own. Look for each of
these in the repository root and read every one you find:
`CLAUDE.md`, `.claude/rules/`, `GEMINI.md`, `.cursor/rules/`, `.cursorrules`, `.github/copilot-instructions.md`, `.windsurfrules`, `.agent-defs/`. The rules above are the floor. Where two rules
differ only in how strict they are, follow the stricter one. Where they cannot
both be followed, stop and ask which one applies.

## Project guides

The guides in `docs/` say how the site is built and written: `voice.md` before writing or editing copy, `design.md` before changing markup or styles, `adding-content.md` before adding content.
