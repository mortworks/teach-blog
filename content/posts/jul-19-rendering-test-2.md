---
# templates.yaml — central source for post scaffolds
# This file supports Hugo blogs using the hugo-composer submodule.
# Each key represents a type of post template.
# Add new entries over time. Maintain clarity with comments and examples.

title: Jul 19 rendering test 2
date: 2025-07-19T13:49:41
lastmod: "2025-07-19T12:49:42Z"
published: "2025-07-19T12:49:42Z"
draft: false
slug: jul-19-rendering-test-2
layout: composite
structure:
  - ref: test-intro
  - ref: test-body
  - ref: test-summary
anchors:
  test-intro: |
    ## Intro

    This is a test intro paragraph.
  test-body: |
    ## Main body

    This is where your main content goes.
  test-summary: |
    ## Summary

    Wrap-up thoughts go here.
# lesson:
#   layout: lesson
#   structure:
#     - ref: warmup
#     - ref: model
#     - ref: analysis
#   anchors:
#     - id: warmup
#       title: Warm-up
#     - id: model
#       title: Model Paragraph
#     - id: analysis
#       title: Analysis
# revision:
#   layout: revision
#   structure:
#     - ref: recap
#     - ref: quiz
#     - ref: summary
#   anchors:
#     - id: recap
#       title: Recap
#     - id: quiz
#       title: Quick Quiz
#     - id: summary
#       title: Summary
---
<!-- test-intro --> <!-- test-body --> <!-- test-summary -->
