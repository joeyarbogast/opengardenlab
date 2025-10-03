# OpenGardenLab Workflow Plan
**Project**: IoT Garden Monitoring System
**Type**: Greenfield Hardware/Software Hybrid
**Created**: 2025-10-01

---

## 🎯 Workflow Overview

This is a **research-first approach** tailored for IoT hardware/software projects. Unlike pure software projects, hardware constraints must inform product decisions.

---

## 📋 Phase 1: Research & Discovery
**Goal**: Establish technical feasibility and constraints before PRD

### Step 1.1: Hardware Platform Research
- **Agent**: `architect`
- **Task**: Technical research on hardware platforms
- **Outputs**:
  - Hardware platform comparison (Raspberry Pi vs ESP32 vs Arduino)
  - CPU/memory/power constraints
  - Language recommendations (Python vs C++ vs Rust)
  - Cost analysis per unit
- **Deliverable**: `docs/hardware-platform-research.md`
- **Command**: `*agent architect` → Request hardware platform research

### Step 1.2: Sensor Selection Research
- **Agent**: `architect`
- **Task**: Evaluate sensor options
- **Outputs**:
  - Soil moisture sensor models & specs
  - Temperature/humidity sensors
  - Light sensors
  - Accuracy, cost, interface type (I2C, analog, etc.)
  - Compatibility with chosen hardware platform
- **Deliverable**: `docs/sensor-selection.md`
- **Command**: Continue with architect or create new focused research doc

### Step 1.3: Plant Database Research
- **Agent**: `analyst` or `architect`
- **Task**: Identify authoritative plant care data sources
- **Outputs**:
  - Available plant databases (USDA, Trefle API, OpenFarm, etc.)
  - API availability and licensing
  - Data completeness (care requirements per species)
  - Recommendation for MVP
- **Deliverable**: `docs/plant-database-research.md`
- **Command**: `*agent analyst` → Request plant database research

### Step 1.4: Research Review & Consolidation
- **Agent**: `architect`
- **Task**: Synthesize research findings
- **Outputs**:
  - Technical constraints summary
  - Recommended tech stack (hardware + software)
  - MVP feasibility assessment
  - Post-MVP technical roadmap
- **Deliverable**: `docs/technical-feasibility.md`
- **Command**: Request architect to consolidate all research

**⏸️ CHECKPOINT**: Review all research documents before moving to PRD

---

## 📋 Phase 2: Product Definition
**Goal**: Create comprehensive PRD informed by research

### Step 2.1: PRD Development
- **Agent**: `pm`
- **Task**: Create Product Requirements Document
- **Inputs**:
  - `project-brief.md` (✅ already created)
  - `technical-feasibility.md`
  - All Phase 1 research docs
- **Outputs**:
  - MVP feature set (scoped by hardware constraints)
  - User stories for gardeners
  - Success metrics
  - Post-MVP roadmap
- **Deliverable**: `docs/prd.md`
- **Command**: `*agent pm` → Request PRD creation with research context

### Step 2.2: UI/UX Specification (Optional for MVP)
- **Agent**: `ux-expert`
- **Task**: Design user interface (if building web dashboard)
- **Inputs**: `prd.md`
- **Outputs**:
  - Screen designs for web dashboard
  - Mobile app wireframes (post-MVP)
  - CLI interface specification
- **Deliverable**: `docs/front-end-spec.md`
- **Command**: `*agent ux-expert` (skip if MVP is CLI-only)

**⏸️ CHECKPOINT**: Review PRD with stakeholders

---

## 📋 Phase 3: Architecture & Design
**Goal**: Create comprehensive system architecture

### Step 3.1: System Architecture
- **Agent**: `architect`
- **Task**: Design full-stack architecture
- **Inputs**:
  - `prd.md`
  - `technical-feasibility.md`
  - `front-end-spec.md` (if exists)
- **Outputs**:
  - Hardware architecture (sensors → controller → network)
  - Software architecture (embedded code + backend + frontend)
  - Data flow diagrams
  - API contracts
  - Database schema
  - Deployment strategy
- **Deliverable**: `docs/fullstack-architecture.md`
- **Command**: `*agent architect` → Request IoT system architecture

### Step 3.2: PRD Updates (If Needed)
- **Agent**: `pm`
- **Task**: Update PRD based on architecture insights
- **Condition**: If architect identifies story gaps or changes
- **Deliverable**: Updated `docs/prd.md`

**⏸️ CHECKPOINT**: Architecture review

---

## 📋 Phase 4: Validation & Preparation
**Goal**: Ensure all artifacts are consistent and complete

### Step 4.1: Document Validation
- **Agent**: `po`
- **Task**: Run PO master checklist
- **Inputs**: All docs in `docs/` folder
- **Outputs**:
  - Consistency validation
  - Completeness check
  - Issue list (if any)
- **Command**: `*agent po` → Request validation with `po-master-checklist`

### Step 4.2: Fix Issues
- **Agent**: Various (based on PO feedback)
- **Task**: Address any gaps or inconsistencies
- **Condition**: If PO finds issues
- **Deliverable**: Updated documents

### Step 4.3: Document Sharding
- **Agent**: `po`
- **Task**: Shard large documents for IDE development
- **Outputs**:
  - `docs/prd/` folder with epic-based shards
  - `docs/architecture/` folder with component shards
- **Command**: `*agent po` → Request document sharding

**⏸️ CHECKPOINT**: All planning complete, ready for development

---

## 📋 Phase 5: Development Execution
**Goal**: Implement stories iteratively

### Step 5.1: Story Creation
- **Agent**: `sm` (Scrum Master)
- **Task**: Create next story from sharded docs
- **Outputs**: `story.md` in Draft status
- **Command**: `*agent sm` → `*create`
- **Repeats**: For each epic in PRD

### Step 5.2: Story Review (Optional)
- **Agent**: `analyst` or `pm`
- **Task**: Review draft story
- **Outputs**: Story updated to Approved status
- **Command**: Review in current chat or new chat

### Step 5.3: Story Implementation
- **Agent**: `dev`
- **Task**: Implement approved story
- **Outputs**:
  - Code implementation
  - Tests
  - Documentation
  - Updated File List in story
- **Deliverable**: Story marked as "Review"
- **Command**: `*agent dev` → Implement story

### Step 5.4: QA Review (Optional)
- **Agent**: `qa`
- **Task**: Senior dev review with refactoring
- **Outputs**:
  - Small fixes applied directly
  - Checklist for remaining items
  - Story status updated (Review → Done)
- **Command**: `*agent qa` → `review-story`

### Step 5.5: Address QA Feedback
- **Agent**: `dev`
- **Task**: Fix remaining QA items
- **Condition**: If QA left unchecked items
- **Command**: Return to dev agent

**🔄 LOOP**: Repeat Steps 5.1-5.5 for all stories

---

## 📋 Phase 6: Retrospective (Optional)
**Goal**: Capture learnings after epic completion

### Step 6.1: Epic Retrospective
- **Agent**: `po`
- **Task**: Validate epic completion and document learnings
- **Outputs**: `epic-retrospective.md`
- **Command**: `*agent po` → Request retrospective

---

## 🎯 Quick Start Commands

### Now (Research Phase):
```
*agent architect
"I need hardware platform research for an IoT garden monitoring system.
Compare Raspberry Pi, ESP32, and Arduino for:
- Sensor support (soil moisture, temp/humidity, light)
- Language options (Python/C++/Rust)
- Power consumption
- Cost per unit
- WiFi capability for data upload
Create docs/hardware-platform-research.md"
```

### Next (After Research):
```
*agent pm
"Create PRD for OpenGardenLab using project-brief.md and research findings.
Focus on MVP features that fit hardware constraints."
```

---

## 📊 Progress Tracking

| Phase | Status | Agent | Deliverable |
|-------|--------|-------|-------------|
| **Phase 1: Research** | ✅ Complete | - | - |
| 1.1 Hardware Platform | ✅ Complete | architect | `hardware-platform-research.md` |
| 1.2 Sensor Selection | ✅ Complete | architect | `sensor-selection.md` |
| 1.3 Plant Database | ✅ Complete | architect | `plant-database-research.md` |
| 1.4 Research Review | ✅ Complete | architect | `technical-feasibility.md` |
| **Hardware Procurement** | ✅ Ordered | - | Arriving in 3-7 days |
| **Phase 2: Product** | ✅ Complete | - | - |
| 2.1 PRD Development | ✅ Complete | pm | `prd.md` |
| 2.2 UI/UX Spec | 🔲 Skipped (included in PRD) | ux-expert | `front-end-spec.md` |
| **Phase 3: Architecture** | ✅ Complete | - | - |
| 3.1 System Architecture | ✅ Complete | architect | `architecture.md` (2,866 lines, Kotlin Android-only) |
| 3.2 PRD Updates | 🔲 Not needed | pm | Updated `prd.md` |
| **Phase 4: Validation** | ✅ Complete | - | - |
| 4.1 Document Validation | ✅ Complete | po | Validation report (87% ready, 2 critical issues fixed) |
| 4.2 Fix Issues | ✅ Complete | po | 3 new stories added (1.10, 1.11, 2.8) |
| 4.3 Document Sharding | ✅ Complete | po | PRD (16 files), Architecture (16 files) |
| **Phase 5: Development** | ⏳ **READY TO START** | - | - |
| 5.1-5.5 Story Cycle | 🔲 Pending | sm/dev/qa | Working software |
| **Phase 6: Retrospective** | 🔲 Optional | po | Learnings doc |

---

## 🚦 Decision Points

### Should you skip UI/UX spec (Step 2.2)?
- **Skip if**: MVP is CLI-only or minimal web dashboard
- **Do it if**: Planning rich web UI or mobile app

### Should you do QA review (Step 5.4)?
- **Skip if**: Solo developer, small project
- **Do it if**: Multiple developers, production system, critical IoT safety

### Should you do epic retrospective (Step 6.1)?
- **Skip if**: Small project, solo dev
- **Do it if**: Team project, learning goals, continuous improvement

---

## 🎬 Your Next Action

**🎉 ALL PLANNING PHASES COMPLETE! Ready for Development 🚀**

You are now ready for **Phase 5: Development Execution**

Your **immediate next step**:

```
*agent sm
```

Then request: "Create the first story from Epic 1" (Story 1.1: Repository Setup)

**What's Ready:**
- ✅ PRD sharded into 16 files: [docs/prd/](docs/prd/)
- ✅ Architecture sharded into 16 files: [docs/architecture/](docs/architecture/)
- ✅ 33 user stories across 4 epics
- ✅ All critical issues resolved (CI/CD, deployment, testing frameworks)

---

**Legend**:
- ✅ Complete
- ⏳ Ready to start
- 🔲 Pending
- 🔄 In progress
