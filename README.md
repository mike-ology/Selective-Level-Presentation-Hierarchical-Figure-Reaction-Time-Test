# Selective Level Presentation Hierarchical Figure Reaction Time Test

## Requirements!

- This program and the associated files were developed using, and are intended for use, with NBS Presentation (v20.3). It should be compatible with the Presentation Package Player and has been tested the Presentation Android (BETA) app.
- The default response keys are [Z], [/] and [SPACEBAR] on standard keyboard. Devices with touchscreens *should* also be compatible.
- This program was intended for use on 1920 x 1020 display devices. Please adjust your screen settings to these dimensions either in Windows or in Presentation itself.
- The program will run under different screen resolutions and will attempt to scale most stimulus parameters. Participants/Researchers will have an opportunity to adjust this scaling further at the beginning of the experiment if a 1920 x 1080 display device is not detected. This additional scaling is primarily intended for mobile devices and tablets where adjusting the resolution may not be possible.

## Overview

The primary purpose of this task is to get an assessment of individual differences in the speed of global and local processing. Importantly, this task differs from many designs in which global and local levels are presented together such as Navon figures. Here, information is presented at the global level *or* local level, but not both. Critically, information at the local level is randomised so that participants must shift their attention from trial to trial.

## General Instructions

- Participants will be presented with a series of hierarchical figures. Letters will be appear at either the global level, constructed by multiple smaller elements, or at the local level, randomly scattered in a larger shape.
- Participants must press the [Z] key if the letter 'E' appears at either the global or local level, and must press the [/] key if the letter 'P' appears at either level (touchscreen responses are E = left-side of screen, P = right-side of screen).
- Participants must ignore all other letters (or a False Alarm is registered).
- Reaction times to global and local trials can be calculated independently from log-file data

## Task Parameters

Several aspects of the task can be easily customised, whilst more advanced changes will require editing the code. Simple parameters include:
- Participant ID as a string
- Adjusting exposure duration / trial length before stimulus disappears / trial ends.
- Enabling or disabling practice trials
- Adjusting the make-up of each block (i.e. the ratio of targets to non-targets)
- Scaling stimuli for screens not running at 1920 x 1080.
- Optionally forcing a temporary save of the output to the C:/ if running from an unstable network connection

## Acknowledgements

If you use this program, either in part or in its entirety, please make acknowledge the source (here!) and the developer (me! Specifically, Michael C W English).

## Citations

Stimuli and task design were drawn primarily from the following studies:
- Iglesias-Fuster, J., Santos-Rodríguez, Y., Trujillo-Barreto, N., & Valdés-Sosa, M. J. (2014). Asynchronous presentation of global and local information reveals effects of attention on brain electrical activity specific to each level. *Frontiers in Psychology*, 5(OCT), 1–14. https://doi.org/10.3389/fpsyg.2014.01570
- Valdés-Sosa, M. J., Iglesias-Fuster, J., & Torres, R. (2014). Attentional selection of levels within hierarchically organized figures is mediated by object-files. *Frontiers in Integrative Neuroscience*, 8(DEC), 1–18. https://doi.org/10.3389/fnint.2014.00091

## Finally...

This is my first GitHub project (and third attempt at 'getting' how Git works)! It was great learning the ins-and-outs of pulling, staging, committing and making branches, and I look forward to using Github for all of my future coding projects now! However, as this is my first project, not everything might have been done correctly in the 'Github way', so drop me some feedback to help me improve if you want. Cheers!
