---
title: "Workflow Plot Editor"
linkTitle: "Workflow Plot Editor"
weight: 99
type: docs
---

This is a SPR workflow editor, which will allow you to edit the workflow plot before/after running a workflow in SPR.

1. Create a SPR workflow with the sysArgsList (sal) object, or directly use the sal object after workflow running. 
2. make a workflow plot with `plotWF(sal)` to take a glimpse of the plot preview. 
3. Use `plotWF(sal, out_format = "dot_print")` to print out the plot in DOT language, copy the whole content to your clipboard. 
4. Use [this link to open **Workflow Plot Editor**](../viz_editor).
5. Paste plot code in the editor to start editing.
