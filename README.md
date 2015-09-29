## CIOC Open Volunteer Classifications ##

This project includes the summary of contributions from the developers and users of CIOC Software as part of the [OpenCIOC Project](http://www.opencioc.org). By providing these values for anyone to use, we (the original content creators) hope to make it easier to find common ways to describe and share Volunteer Positions.

An additional project is available for lists used to help describing organization, service and contact records. It is available at https://github.com/OpenCIOC/communityinfoclassifications

### File Formats ###

All lists are provided in CSV (comma-seperated value) files, including a header row which describes the fields. Most files have a *Code* field followed by one or more *Name* fields which are denoted in brackets by the language-specific *culture code* such as en-CA (Canadian English) or fr-CA (Canadian French).

Want to use this project, but wish another file format was available? We're happy to consider releasing the data in anther format such (e.g. XML) if there is a demand. Just ask!

### Types of Data Available ###

 - **Interaction Level** (interactionlevel.csv) describes how much person-to-person interaction can be expected from the Opportunity
 - **Areas of Interest (Specific)** (interest.csv) describes specific types of activities or categories of opportunity, from the perspective of the potential Volunteer. May fall under multiple general categories
 - **Areas of Interest (General)** (interestgroup.csv) provide general categories under which to file *Specific* Areas of Interest
 - **Seasons** (season.csv) indicate whether an opportunity is available in a specific season and/or year-round
 - **Skills and Experience** (skillexperience.csv) describes specific characteristics or skills that are desired by the organization offering the Opportunity
 - **Suitability** (suitability.csv) indicates whether a position is suitable for a potential Volunteer that is part of a specific target population (e.g. men, women, families, persons with disabilities) or volunteering for a specific reason (e.g. school credit, court ordered service hours)
 - **Training** (training.csv) indicates whether training is required or offered
 - **Transportation** (transportation.csv) indicates whether there are specific requirements around transportation (for example needing a driving or chauffeur license) or special transportation considerations (such as being near a public transit route)

Note that it is expected that some of these data points require elaboration within any target system that uses them. For example, there is likely to be more information required about Skills and Experience, Suitability, and Training than what can be covered by a pre-defined checklist.

### Languages and Translations ###

The lists are currently available in Canadian English and Canadian French. This project welcomes the contribution of translations to other languages or language variants. The txt directory contains text versions of the names of items, used to manage the [translation project on Transifex](https://www.transifex.com/open-cioc/cioc-volunteer-classifications). Contributions of translations in other languages are welcome - please use the Transifex project to contribute.

### License and Attribution ###

These lists are licensed under the Creative Commons Zero license (https://creativecommons.org/publicdomain/zero/1.0/). Attribution (without the implication of endorsement) is appreciated, so that others may benefit from this project.

If you choose to expand or add to this data, **please consider contributing it back to the project** so that everyone can benefit.