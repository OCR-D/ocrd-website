---
layout: page
title: How we want to develop software in OCR-D
lang: en
lang-ref: best-practices
---

# Best Practices for Software Development in OCR-D

This guide is informed by the experience of coordinating distributed development of the [OCR-D software and specifications](https://github.com/OCR-D). We strive for a broad consensus on the practicalities and logistics of software development, particular in preparation of the upcoming [Phase III of OCR-D](https://ocr-d.de/en/2020/06/04/pilot.html).

## Communications

> [Be bold](https://en.wikipedia.org/wiki/Wikipedia:Be_bold)

Software Development is as much a social endeavor as it is technical. To effectively develop in a distributed setting, transparency and sharing early in the process is vital. We therefore strongly recommend using the following channels over E-Mail.

### GitHub Account

Since all development shall be openly and transparently carried out on GitHub, it is essential that you [create a GitHub account](https://github.com/join).

### Chat

The [OCR-D gitter "Lobby"](https://gitter.im/OCR-D/Lobby) is the general channel for all things OCR-D. We strive to keep the threshold for participation as low as possible. Every question or is welcome. It is also the channel we use to announce changes to [OCR-D core](https://github.com/OCR-D/core), the [specifications](https://github.com/OCR-D/spec) or updates on [processors](https://github.com/topics/ocr-d).

Gitter accounts can also be used for private/direct conversations, for which the contacts in the Lobby are a good starting point.
### GitHub Issues

As with the [chat](#chat), we aim for low barriers of entry for participation on issues in GitHub. If something is not working within OCR-D projects, you encounter error messages or unexpected behavior: Feel free to open an issue. If you cannot identify which component or project is the cause of the problem, [open an issue in OCR-D/core](https://github.com/OCR-D/core/issues/new), the moderators can transfer it to the right place later.

This openness must go both ways: If you maintain or contribute to a project, it is essential that we treat each other with respect. Many users and even developers are still learning about OCR, software development and distributed version control. A clueless "newbie" can become a helpful contributor if you support them.

### GitHub Forks

A *fork* is a clone of a GitHub repository hosted on the same site. If you fork a repository, a clone of it will be created under your username. The advantage of a fork over just the original repository is that you have full control of it and can make changes to it to fit your use case, while others also can access it. If you deem your changes a useful contribution to the original project, you can create a [pull request](#pull-request) to allow discussing and refining them with others, and ultimately merge.

### Pull Requests

**TODO** Explain how suggestions work

A *pull request* ("PR", in Gitlab they are called *merge requests*) is essentially an [issue](#github-issues) with an attached Git branch of either the repository or one of the [forks](#github-forks). You should create a dedicated branch for your Pull Request. Describe the changes you are proposing in a concise manner and try to find a good title. Try to keep PR as small as possible, ideally not more than a handful of changed files or a few dozen changed lines at most. If a PR is too large to review and integrate effectively, consider splitting it into smaller PRs.

If you are maintaining a project and somebody sends a PR: great, because that means your users are not only interested in your software but also willing to spend time on improving it. Check the "Files" tab of the PR to see a visualization of the changes. You can comment directly on code lines, which helps to focus the discussion on specific changes. Once such a discussion is complete, click on "Resolve conversation" which will hide these finished conversations. You can review a PR and either approve, request changes or reject a PR. Nobody likes to feel rejected, so try to help improve a suboptimal PR rather than outright rejecting it.

### Wiki

The [wiki of the ocrd-website](https://github.com/OCR-D/ocrd-website) is the central repository for user-generated documentation, and complements [the official OCR-D website](#website). If you have any experiences, configurations, scenarios or documentation in general which are related to your use of OCR-D software, feel free to contribute them to the Wiki. To add a new page, click on "New Page", decide on a concise title for the page and add your information.

It is easy to reorganize and edit pages later, so do not feel pressured to overcome a relevancy threshold. Everybody profits from sharing experiences in the long run. Additionally, the wiki serves as a source for [official documentation](#website) and the coordination project is very much interested in letting the official documentation be strongly informed by the experience of OCR-D users.

### Website

The official website of OCR-D is https://ocr-d.de. You can find documentation, tailored towards [users](https://ocr-d.de/en/use) and [developers](https://ocr-d.de/en/use), as well as a [blog](https://ocr-d.de/en/blog) and much more.

The website itself is available as repository [OCR-D/ocrd-website](https://github.com/OCR-D/ocrd-website) on GitHub. If you have any comments or questions, don't understand a section of the documentation or have found typos or broken links: Please [open an issue in ocrd-website](https://github.com/OCR-D/ocrd-website/issues/new)! We are also happy to merge PR for the website, but issues are just as helpful.

## Development Workflow

### Git basics

Before doing anything else, [configure the user name and e-mail](https://help.github.com/en/github/using-git/setting-your-username-in-git) you want to assign to your commits:

```sh
git config --global user.name "Erika Mustermann"
git config --global user.email "erika@mustermann.de"
```

Also make sure that the e-mail address you use is [linked to your GitHub account](https://github.com/settings/emails) so your commits will be attributed to you, even if you use another e-mail address than the one you registered with.

It is worth investing some time in studying quality-of-life features of git, such as [aliases](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) or [shell integration](https://git-scm.com/book/en/v2/Appendix-A%3A-Git-in-Other-Environments-Graphical-Interfaces) as these will make working with git substantially more pleasant. Also consider mining [`$HOME/.gitconfig` files on GitHub](https://github.com/search?q=.gitconfig) for your own setup.

### Branches and Pull Requests

As mentioned in the [section on Pull Requests](#pull-requests), you should organize your changes in *feature branches* that contain a narrow set of commits. When new features depend on others, don't hesitate to branch from branches.

### Unit tests

Unit tests are code that makes assertions over the behavior of the components of your main code, which can be used for automatic regression testing.

### Code Coverage

The coverage of your tests is the percentage of lines of code that were executed running all your tests. You should strive for 100% coverage, so that everything your code does is encountered by the tests at least once. Even though a high code coverage is no panacea against bugs, it substantially reduces the amount of regressions, i.e. code changes that unexpectedly break existing behavior.

### Test data

The OCR-D coordination project maintains a central repository [OCR-D/assets](https://github.com/OCR-D/assets) that contains test data for unit tests. The test data consists of [unpacked OCRD-ZIP](https://ocr-d.de/en/spec/ocrd_zip) of workspaces, i.e. one or more METS XML files, as well as PAGE-XML, ALTO, images. While they use the same mechanism, **these folders are not Ground Truth**. Instead, they serve as examples of a wide range of "real-life" data, warts and all. When testing your software, consider using the data from [OCR-D/assets](https://github.com/OCR-D/assets). If none of the provided OCRD-ZIP satisfy your needs, please [open an issue in OCR-D/assets](https://github.com/OCR-D/assets/issues/new) and describe your test data needs, so we can cooperate on creating test data.

Making uniform and well-described test data available to all serves everybody and the coordination project will continue to maintain and update the test data as requirements shift or specifications change. Such a test-specific corpus also improves comparability of processor performance and frees test engineers to focus on testing the actual software, not wrangling with their own test data.

### Continuous Integration

Continuous Integration (CI) platforms offer computing ressources to software developers that allow building and testing software. These platforms, such as [Travis CI](https://travis.com), [Circle CI](https://circleci.com), [Scrutinizer](https://scrutinizer.com) or [GitHub Actions](https://github.com/actions) can be integrated into GitHub repositories to automatically build/test when certain actions happen, such as "a PR was opened" or "new commit to master branch". The big advantage of CI is that you can automate testing of changes to your software in a variety of environments, so you can be confident that a PR did not introduce introduce regressions or break for an operating system you didn't anticipate.

### Semantic Versioning

There is a wide variety of versioning schemes, such as date-based or plain incremental integers. At OCR-D we favor [Semantic Versioning](https://semver.org/). In essence, a version should have the syntax `MAJOR.MINOR.PATCH` with this convention:

  * Increase `MAJOR` by one if a changeset introduces **breaking changes**.
  * Increase `MINOR` by one if a changeset introduces **new features**.
  * Increase `PATCH` by one if a changeset **fixes problems with the minor version**.

You should start versioning at `0.0.1`. While `MAJOR` is `0`, the software is to be considered alpha but you should still stick to the scheme for minor and patch revisions. Once you consider the software mature enought to merit a `1.0.0` release, take extra care to adhere to the convention as much as possible.

The advantage of semantic versioning is that it conveys the consequences of an upgrade to the user. There is never a reason not to upgrade to the latest patch release whereas a upgrading to a new major version should be undertaken with care.

## Licensing

OCR-D is firmly committed to the values of [F(L)OSS](https://en.wikipedia.org/wiki/Free_and_open-source_software) and [permissive licensing](https://en.wikipedia.org/wiki/Permissive_software_license), as these not only encourage community use and uptake, but also create trust between all stakeholders and transparency of the development process.

OCR-D favours the [Apache Software License 2.0](https://www.apache.org/licenses/LICENSE-2.0) (ASL) for it is a permissive license that supports the waiving of liabilities while still granting sufficient freedom for e.g. commercial parties to use and redistribute products that include source code from OCR-D.

Second to the ASL, other permissive open source licenses that can be used include (in order of preference): [MIT](https://en.wikipedia.org/wiki/MIT_License), [BSD](https://en.wikipedia.org/wiki/BSD_licenses). If there are strong reasons that prevent using a permissive license for your project, please [get in touch with the coordination project](https://ocr-d.de/en/contact) to discuss other licensing options. <!--Weakly permissive licenses such as e.g. GPL, LGPL, APGL should only be used when there are strong reasons against the use of a permissive license. -->

## Python project setup

Since most processors are implemented in Python, we have been developing certain conventions that have proven effective for interoperability, deployment and robustness. Following these conventions makes it easier to contribute and frees developers from the grunt work of managing a project, to spend more time on development, documentation and support.

Have a look at existing projects that follow these cvonventions, e.g. [`ocrd_tesserocr`](https://github.com/OCR-D/ocrd_tesserocr). Much can be copied, pasted and adapted.

### Project layout

When starting a new project `ocrd_foo`, create this folder layout:

```sh
ocrd_foo/
ocrd_foo/__init__.py
tests/test_foo.py
LICENSE
README.md
setup.py
```

### `setup.py`

We use `setuptools` for python packaging in OCR-D.

### `tests/`

### `LICENSE`

## Deployment

### Dockerfile

### ocrd_all
