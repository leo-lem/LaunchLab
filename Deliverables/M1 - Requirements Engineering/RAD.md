# Requirements Analysis Document

---
#### Project - Transferagentur
#### Team - Hanna Lagerbauer, Henrik Marcussen, Jai Kamboj, Eric Liebrecht, Maximilian Stabe, Leopold Lemmermann
#### Date - November 14th 2024

1. [Introduction](#introduction)  
2. [Current System](#current-system)
3. [Proposed System](#proposed-system)  
<!-- 4. [Acronyms and Abbreviations](#acronyms-and-abbreviations)  -->
<!-- 5. [Glossary](#glossary)  -->

<details>
  <summary> Purpose & Audience </summary>

  ### Purpose
  The Requirements Analysis Document (RAD) describes the results of the requirements elicitation and the analysis activities. It serves as a contractual basis between the client and the developers, and focuses mainly on the project's problem space, not the solution space. It characterizes the client's current situation with an insufficient or non-existing software system and details the functional and non-functional requirements that the new, innovative software system must fulfill.

  ### Audience
  The RAD's audience includes:

  - The client.
  - The end users.
  - The project manager.
  -	The system analysts (i.e., the developers managing the requirements).
  -	The system designers (i.e., the developers designing the system).

  The RAD template below was introduced in the book "Object-Oriented Software Engineering Using UML, Patterns, and Java" (Bernd Bruegge and Allan H. Dutoit). For more information, see Chapter 4 (Requirements Elicitation) and Chapter 5 (Analysis).
</details>

---


## Introduction
<!-- The Introduction's purpose is to provide a brief overview. -->
ScaleUp. From nothing to success. It's the app to help you find ideas, refine them into a product, found a company around that product, and scale that company to success.

Currently, all of the consultation process is handled by Transferagentur's consultants. We want to make that consultation digital. One app to guide you from nothing to success. And what's even better: It comes with it's own startup consultant AI, Chatpreneur.

### Purpose of the System
<!-- Purpose and reasons for development. -->
We want to foster startup culture and enable people to fulfill their dreams. Oftentimes, people are motivated, have ideas, but they don't know how to proceed. We give them a companion they can turn to.

### Scope of the System
<!-- The functional and non-functional scope of the system. -->
We choose to approach the problem from two different angles:
1. ScaleUp - iOS-based app, targeted specifically to people who are motivated to create something. Whether they don't even have an idea, or they've already founded their company, it's there to help.
2. ScaleUp: Chatpreneur - AI assistant for anything related to creating a product, building a startup, and becoming successful.

### Objectives and Success Criteria of the Project
<!-- Objectives and success criteria of this M-Lab project. -->
1. ScaleUp brings the user a step forward (i.e., from nothing to an idea, from and idea to a product, from a product to a company, …).
2. ScaleUp: Chatpreneur supports in specific startup related questions and research.

### References
<!-- References to the development context (e.g., references to the client's problem statement, to existing systems, or to feasibility studies) -->
* [StartupPort guides](https://startupport.de/en/expertise-ressourcen/)
* [Guide to write a Startup business plan](https://www.wrike.com/blog/12-steps-to-a-startup-business-plan-infographic/)
* [Short intruduction what Sartups are and how they work](https://www.forbes.com/advisor/business/what-is-a-startup/)
* [The language used in Startups](https://www.lingoda.com/blog/en/learn-the-startup-language-culture-and-values/)
* [10 steps to start with a business](https://www.sba.gov/business-guide/10-steps-start-your-business)
* [Overview of the different german legal forms](https://www.existenzgruendungsportal.de/Navigation/DE/Gruendungswissen/Rechtsformen/rechtsformen.html)


## Current System
<!-- This section describes the current situation. If your new system will replace an existing system, describe the existing system's functionality and problem in its usage. Otherwise, explain how the new system's client or users currently accomplish the tasks that the system supports. -->
Currently, Transferagentur’s consultation process is fully handled by consultants, relying on their extensive research skills and domain expertise. The process typically follows a structured approach that includes multiple stages to accommodate clients’ varying needs.
1.	Initial Consultation (Erstgespräch):
	-	Objective: Identify or clarify the client’s business ideas.
	-	No Idea: Tools like Design Thinking, Canvas Models, and ideation tools are employed to help clients identify friction points in their lives.
	-	Too Many Ideas: Consultants recommend listing, categorizing, and prioritizing ideas using a matrix to evaluate effort, goals, and personal alignment.
	-	Vague Idea: Lean Canvas and Business Model Canvas (BMC) templates are used to document and structure initial concepts, providing clients with a toolkit for idea development.
2.	Second Consultation (Zweitgespräch):
	-	Focus: Customer contact and idea validation, particularly for B2C ideas.
	-	Tools and Methods: The Value Proposition Canvas and persona creation are central. Consultants often guide clients through testing their ideas via direct conversations with potential customers, and occasionally collaborate with research institutions for patentable ideas.

Clients span various demographics, including students (primarily postgraduates), researchers, and innovative individuals suited for funding opportunities. Common challenges include idea validation, prototype development with limited resources, and securing funding or investors.

Transferagentur consultants provide critical data and resources, such as target audience data, market analyses, and funding application checklists. Consultants frequently address topics like financial planning, market entry strategies, and intellectual property concerns, with time-intensive areas focused on customer analysis, business plan creation, and optimizing funding applications.

Standardized elements, such as toolkits for idea assessment and persona development, help streamline the process, though customization remains integral to meet clients’ specific needs based on their industry, development stage, and intended audience.



## Proposed System
<!-- This section documents the requirements elicitation and the analysis model of the new system. Start with an overview of the new system's features and qualities. You can include appropriate UML diagrams for this overview and briefly describe their content. -->
The proposed “ScaleUp” system is a mobile app designed to guide users, especially aspiring entrepreneurs, through the process of building and refining their startup ideas. It combines interactive learning modules, personalized onboarding, and AI-based support, creating an engaging and structured path for users to develop essential startup skills. Key features include guided modules on startup topics, personalized progress tracking, and integrated AI support.



### Functional Requirements
<!-- Functional requirements describe the system's high-level functionality. We recommend presenting these requirements using an appropriate template (e.g., Rupp's requirements template or the EARS template by Mavin et al.). -->
1. **Onboard the user** - When opening the app for the first time, onboarding shall begin. This onboarding shall yield relevant user information (name, product name, …) and find out the user's current knowledge level to show relevant modules afterwards.
2. **Modules** - The app shall be centered around workshop-like modules that teach the user relevant start-up skills and confer relevant knowledge and information. Some modules shall need to be unlocked. The module's state shall be reflected by its color.
3. **Consult with Transferagentur module** - The app shall offer a module to contact a Transferagentur consultant and arrange a consultation. This module shall include an option to export the user information to a suitable format for the consultant. The module should be optional but present so the user knows he has this option.
4. **Output personalized artifacts** - Some modules shall output personalized artifacts (like a pitch deck or business plan).
5. **Progress bar** - A progress bar shall be filled when the user progresses through modules and gains startup skills and knowledge. This progress bar shall indicate how far along the user is in our app and in creating his startup. It shall include milestones.
6. **Module progress circle** - The app shall display a progress circle to summarize module completion. The progress bar shall transition into this progress circle with an impressive animation.

7. **Chat integration** - The app shall have an integrated GenAI 'EntrepreneurChat' to answer user questions. This chat shall be omnipresent with a floating button and be displayed in an overlay.
8. **Context for chat feature** - The app's chat feature shall provide user information as context for the GenAI model (RAG approach), personalizing the experience and making the integration seamless.

9. **Forward to app** - The chat shall point to the app when appropriate for the user.
10. **Startup domain knowledge** - The chat shall offer startup domain knowledge.
11. **Context-related answers** - The chat provides answers based on the current course of the conversation so that the advice is tailored to the individual context.
12. **Provide sources** - The chat shall provide sources if required for the answer (e.g., links to articles, lists of contact points, or documents)."
**Progress bar milestones** - The progress bar shall have milestones unlocked with module completion (newbie, advanced, …).



### Non-functional Requirements
<!-- Non-functional requirements describe the qualities that characterize the new system. These requirements must be measurable and testable. Use concrete acceptance thresholds to describe them. Refer to standards like ISO 25010 for a more extensive list, but here are some exemplary requirements:
Usability, Reliability, Performace, Supportability, Implementation Requirements, Interface Requirements, Packaging Requirements, Legal Requirements -->
1. **Usability I: Easy Introduction** - To minimize the entry hurdle, introduction and onboarding shall be intuitive, engaging, and well-paced.
2. **Usability II: Minimalistic but straightforward** - The user interface shall be minimalistic and straightforward to keep users engaged but not overwhelmed.
3. **Broad availability** - The chat shall be available to aspiring entrepreneurs, people vaguely interested in start-ups, consultants, and basically anybody who wants to use it. This is achieved by making it insertable into other webpages (our marketing page, the Transferagentur page, etc.) and not restricting it via login.



### System Models
<!-- This section describes scenarios, use-case models, object models, dynamic models, and user interface ideas for the new system. -->

#### Scenarios & Use Cases
<!-- Phrase the scenarios are concrete, focused, informal descriptions of the system's use and include one or multiple use cases per scenario. -->
##### Scenario 1: Onboarding and First Steps
**User:** Anna, a graphic designer with an idea for a sustainable fashion label. \
**Goal:** Anna wants to find out what steps she needs to take to concretize her idea and find out if it is commercially viable. \
**Description:** \
Anna downloads the app and starts the onboarding process. She is guided through questions that capture her level of knowledge and the current status of her idea, such as: “Have you already conducted market research?” or ”Do you already have a rough idea of your product or service?” Based on Anna's answers, the app suggests that she take the first steps towards market research and carry out a target group analysis. The app sets up Anna's dashboard so that her progress is visible at all times and Anna can directly access the tools for idea development and target group analysis.

##### Scenario 2: Support with the creation of a business plan
**User:** Ben, an experienced software developer who wants to found a tech startup.\
**Goal:** Ben needs support to structure his business idea into a formal business plan.\
**Description:** \
After onboarding, the app gives Ben the opportunity to speak directly with the digital consultant, as Ben already has previous experience in the business creation process. He asks specific questions about market strategy and financial planning. The custom GPT consultant helps Ben to structure a business plan and gives advice on how to present it. Ben also receives suggestions on how he could design his pitch deck to appeal to potential investors. For more detailed questions about specific legal requirements, the app directs Ben to external consultants who specialize in startups.

##### Scenario 3: Idea development and pitch deck creation
**User:** Clara, a social entrepreneur who has a concept for a non-profit educational project. \
**Goal:** Clara wants to refine her idea and create a convincing pitch deck to acquire funding. \
**Description:** \
After assessing her level of knowledge and start-up experience, her dashboard is also created. Clara works with the AI to refine her ideas, develop guiding questions for her target groups and create concrete examples of problem-solving approaches. The app guides Clara step-by-step through the creation of a pitch deck and offers suggestions on structure, content and design to present her project in a convincing way. As Clara formulates the specific goals of her social mission, she can ask specific questions and receive feedback from the AI at any time. If Clara has detailed questions about applying for funding, she is referred to a consultant who specializes in non-profit projects.

##### Use case 1: Onboarding and profile customization
**Goal:** The app adapts to the user's level of knowledge and progress in the start-up process. \
**Stakeholder:** User (e.g. Anna, the graphic designer) \
**Description:**
1. The user starts the onboarding and is guided through a series of questions that capture the current state of the business idea and start-up knowledge.
2. Based on the answers, the user receives a personalized dashboard and a to-do list with the next steps specifically tailored to their level of knowledge.
3. Onboarding guides the user to a collection of resources and tools tailored to their progress and knowledge.

**Result:** The user receives a personalized app setting that provides targeted support and can see progress at each key stage.

##### Use Case 2: Asking Questions to the Digital Consultant
**Goal:** The user receives specific answers and support from the AI-based digital consultant. \
**Stakeholder:** User (e.g. Ben, the software developer) \
**Description:**
1. The user opens the chat interface of the digital consultant and asks a question on a topic such as “How do I formulate a USP for my market?”
2. The AI analyzes the question and provides a detailed answer that addresses the specific requirements of the user's company.
3. The user can ask further questions or search specifically for recommendations and resources, e.g., to analyze the competition.

**Result:** The user receives specific answers and suggested actions to refine idea development and is directed to appropriate, specialized resources for more in-depth questions.


##### Use Case 3: Business Plan Creation with AI Support
**Goal:** The user creates a complete business plan together with the AI. \
**Stakeholder:** User (e.g. Ben, the software developer) \
**Description:**
1. The user selects the “Create Business Plan” option in the dashboard.
2. The app asks questions about the core areas of the business plan, such as market analysis, financial planning, product range, and target group.
3. Based on the answers, the business plan is continuously supplemented and structured. The AI makes recommendations for each section and suggests formulations.
4. Once the business plan has been completed, the user can export the document as a PDF or process it further as a pitch deck.

**Result:** The user has a comprehensive business plan that has been structured and formulated with the support of the AI and serves as a basis for the search for investors.

##### Use Case 4: Pitch Deck Creation and Optimization
**Goal:** The user creates a convincing pitch deck with the help of AI. \
**Stakeholder:** User (e.g. Clara, the social entrepreneur) \
**Description:**
1. The user selects the option “Create Pitch Deck” and specifies the type of audience the deck is intended for (e.g., investors or funding providers).
2. The AI helps the user to summarize the most important points of their idea and gives suggestions on how to best present the target group, solution, and unique selling points.
3. The user can iteratively improve the pitch deck and receive feedback from the AI, for example on comprehensibility and structure.
4. The app provides design templates and helps the user to export the pitch deck as a visually appealing presentation.

**Result:** The user has a structured, well-formulated pitch deck that is ready for presentations.

##### Use Case 5: Forwarding to Specialized Consultants
**Goal:** The user is forwarded to external consultants for complex questions. \
**Stakeholder:** User (e.g. Clara, the social entrepreneur) \
**Description:**
1. The user asks a specific question about applying for funding that requires more in-depth, specialist expertise.
2. The AI recognizes that the request is outside the app's scope of knowledge and suggests forwarding the user to a specialist advisor.
3. The user receives a list of consultants and can contact a suitable expert depending on their preference.

**Result:** The user is forwarded to a specialized consultant for very specific topics and receives personalized support.

#### Object Model
<!-- Use appropriate UML diagrams to present the models. -->

The object model for the ScaleUp app represents a user-driven learning app structured as follows:

- **User**: Tracks a user’s progress, onboarding responses, and chat messages. Links to multiple modules they can complete.
- **Module**: Represents a learning module with a name, completion status, and the current page. Contains multiple pages (ModulePageContent).
-	**ModulePageContent**: Each page within a module, with text, optional images, and quiz elements (question, answer choices, and correct answer index).

The relationships allow a user to access various modules, each composed of multiple interactive content pages, supporting structured learning and progress tracking.

[![ObjectModel](https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202425/transferagentur/-/wikis/uploads/eede5a606ea92e57c8ce7cb3461412cf/SWT.png)](https://lucid.app/lucidchart/8adbcb90-c5f6-4e31-8d6f-7017b931f316/view)

Refer also to [LucidChart](https://lucid.app/lucidchart/8adbcb90-c5f6-4e31-8d6f-7017b931f316/view).

#### User Interface
<!-- Use mock-up screens to illustrate the system's user interface and connect the screens with arrows to show navigational paths. -->

1.	Onboarding and Initial Assessment:
- Welcome & Introduction: The app introduces itself with a welcome screen and a call to action to get started.
-	User Profiling: The app asks users about their familiarity with business concepts, their experience with startups, and knowledge of their target market. This onboarding survey helps customize the user experience based on their expertise level.
2.	Content Modules & Navigation:
- Topics Overview: Users are presented with a selection of modules (e.g., Market Analysis, Advertising, Strategy Plan), each containing multiple resources or exercises related to each topic. This section allows users to choose where to start based on their learning priorities.
-	Progress Tracking: Progress indicators visually track the user’s completion status in each module, offering an overview of their advancement.
3.	Individual Module Breakdown:
- Each module includes specific sections focusing on essential business topics.
-	Interactive Assessments: Progress within modules is tracked through interactive elements that could include quizzes or exercises, as indicated by a “Start” or “Continue” button.
4.	Progress Summary: Users can view a holistic summary of their learning and progress in different topics. A circular progress bar and percentage indicators allow them to see how close they are to completion within each area.
5.	Chat Support or Guidance: An LLM chat overlay is always available after the onboarding, to help out with any questions the user may have. This chat utilizes the personal information collected in the onboarding and modules.

[![Prototype](https://git.informatik.uni-hamburg.de/mast/teaching/mlab/wt202425/transferagentur/-/wikis/uploads/c37b9cb951758d5d8f0adfc350800802/ScaleUp.png)](https://www.figma.com/proto/bFe6jqSDZ2OXyaKYpr3xej/Prototyping?node-id=206-4249&t=OR6ztRCPCX8z2gOR-1&starting-point-node-id=206%3A4249)

Our click dummy prototype is available in [Figma](https://www.figma.com/proto/bFe6jqSDZ2OXyaKYpr3xej/Prototyping?node-id=206-4249&t=OR6ztRCPCX8z2gOR-1&starting-point-node-id=206%3A4249).



<!-- ## Acronyms and Abbreviations -->
<!-- Add a list of acronyms and abbreviations used in this document, along with their spelled-out versions. This section is optional; omit it if you do not use acronyms or abbreviations. -->




<!-- ## Glossary -->
<!-- Add a glossary of important terms used in this document to ensure consistency in their specification and a shared understanding of terms used by the client. -->
