# VoltAgent Subagents Plugin Guide

> **Plugin Suite:** `voltagent-subagents@VoltAgent/awesome-claude-code-subagents`
> **Version:** 1.0.1
> **Scope:** User (global)
> **Category:** Specialized Development Agents (6 plugins, 94 agents)

---

## Overview

VoltAgent Subagents is a suite of 6 plugin packages containing **94 specialized AI agents** that cover every aspect of the software development lifecycle. Each agent is a deeply-specialized expert that activates as a Task subagent with its own context, tools, and domain knowledge.

**How they work:** The Task tool invokes these agents with `subagent_type: "<plugin>:<agent>"`. Each agent has full access to the codebase, runs autonomously, and returns a structured result. Claude orchestrates multiple agents in parallel for complex tasks.

---

## Plugin Packages

| Plugin | Agents | Domain |
|--------|--------|--------|
| `voltagent-core-dev` | 10 | Full-stack web development |
| `voltagent-data-ai` | 12 | Data engineering, ML, AI |
| `voltagent-dev-exp` | 13 | Developer experience and tooling |
| `voltagent-infra` | 16 | Infrastructure and DevOps |
| `voltagent-lang` | 26 | Language/framework specialists |
| `voltagent-qa-sec` | 14 | QA, security, and testing |

---

## voltagent-core-dev (10 Agents)

Full-stack web architecture and development specialists.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| API Designer | `voltagent-core-dev:api-designer` | REST/GraphQL design, OpenAPI specs, authentication patterns |
| Backend Developer | `voltagent-core-dev:backend-developer` | Server-side APIs, microservices, scalable architecture |
| Electron Pro | `voltagent-core-dev:electron-pro` | Desktop apps, native OS integration, distribution |
| Frontend Developer | `voltagent-core-dev:frontend-developer` | React/Vue/Angular multi-framework frontend |
| Fullstack Developer | `voltagent-core-dev:fullstack-developer` | Features spanning DB + API + frontend together |
| GraphQL Architect | `voltagent-core-dev:graphql-architect` | GraphQL schemas, federation, query optimization |
| Microservices Architect | `voltagent-core-dev:microservices-architect` | Distributed system design, service decomposition |
| Mobile Developer | `voltagent-core-dev:mobile-developer` | React Native/Flutter cross-platform (80%+ code share) |
| UI Designer | `voltagent-core-dev:ui-designer` | Visual interfaces, design systems, accessibility |
| WebSocket Engineer | `voltagent-core-dev:websocket-engineer` | Real-time bidirectional communication at scale |

**M3Dev Use Cases:**
- `api-designer` — Design inference API endpoints and schemas
- `backend-developer` — Build M3Dev platform backend services
- `fullstack-developer` — Complete ML dashboard features
- `websocket-engineer` — Real-time inference streaming endpoints

---

## voltagent-data-ai (12 Agents)

Data engineering, ML systems, and AI infrastructure specialists.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| AI Engineer | `voltagent-data-ai:ai-engineer` | End-to-end AI systems: training → production → monitoring |
| Data Analyst | `voltagent-data-ai:data-analyst` | Business insights, dashboards, statistical analysis |
| Data Engineer | `voltagent-data-ai:data-engineer` | ETL/ELT pipelines, data infrastructure, orchestration |
| Data Scientist | `voltagent-data-ai:data-scientist` | EDA, hypothesis testing, ML model development |
| Database Optimizer | `voltagent-data-ai:database-optimizer` | Slow query diagnosis, indexing strategy, multi-DB |
| LLM Architect | `voltagent-data-ai:llm-architect` | LLM production systems, fine-tuning, RAG, serving |
| Machine Learning Engineer | `voltagent-data-ai:machine-learning-engineer` | Deploy and serve ML models at scale |
| ML Engineer | `voltagent-data-ai:ml-engineer` | Training pipelines, serving infra, automated retraining |
| MLOps Engineer | `voltagent-data-ai:mlops-engineer` | ML infrastructure, CI/CD for models, experiment tracking |
| NLP Engineer | `voltagent-data-ai:nlp-engineer` | NLP systems, text processing, language model tasks |
| Postgres Pro | `voltagent-data-ai:postgres-pro` | PostgreSQL performance, HA replication, advanced features |
| Prompt Engineer | `voltagent-data-ai:prompt-engineer` | Production prompt design, optimization, evaluation |

**M3Dev Use Cases:**
- `llm-architect` — Design M3Dev's LLM serving architecture
- `mlops-engineer` — Set up automated model deployment pipelines
- `ml-engineer` — Build training and fine-tuning pipelines
- `data-engineer` — Build data collection and processing pipelines

---

## voltagent-dev-exp (13 Agents)

Developer experience, tooling, and code quality specialists.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| Build Engineer | `voltagent-dev-exp:build-engineer` | Build performance, compilation optimization |
| CLI Developer | `voltagent-dev-exp:cli-developer` | CLI tools, terminal UX, cross-platform commands |
| Dependency Manager | `voltagent-dev-exp:dependency-manager` | Vulnerability audits, version conflicts, bundle size |
| Documentation Engineer | `voltagent-dev-exp:documentation-engineer` | API docs, tutorials, guides that stay current |
| DX Optimizer | `voltagent-dev-exp:dx-optimizer` | Build times, feedback loops, developer satisfaction |
| Git Workflow Manager | `voltagent-dev-exp:git-workflow-manager` | Git workflows, branching strategies, merge management |
| Legacy Modernizer | `voltagent-dev-exp:legacy-modernizer` | Incremental migration, tech debt reduction |
| MCP Developer | `voltagent-dev-exp:mcp-developer` | MCP servers/clients connecting AI to external tools |
| PowerShell Module Architect | `voltagent-dev-exp:powershell-module-architect` | PS module design, profile systems, reusable automation |
| PowerShell UI Architect | `voltagent-dev-exp:powershell-ui-architect` | WinForms/WPF/TUI for PowerShell automation tools |
| Refactoring Specialist | `voltagent-dev-exp:refactoring-specialist` | Transform poorly structured code while preserving behavior |
| Slack Expert | `voltagent-dev-exp:slack-expert` | Slack app development and API integrations |
| Tooling Engineer | `voltagent-dev-exp:tooling-engineer` | CLIs, code generators, build tools, IDE extensions |

**M3Dev Use Cases:**
- `mcp-developer` — Build custom MCP servers for M3Dev tooling
- `documentation-engineer` — Generate and maintain API documentation
- `refactoring-specialist` — Clean up technical debt in existing modules

---

## voltagent-infra (16 Agents)

Infrastructure, cloud, DevOps, and security specialists.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| Azure Infra Engineer | `voltagent-infra:azure-infra-engineer` | Azure network, Entra ID, PowerShell, Bicep IaC |
| Cloud Architect | `voltagent-infra:cloud-architect` | Multi-cloud strategy, migrations, DR, cost optimization |
| Database Administrator | `voltagent-infra:database-administrator` | DB performance, HA architectures, disaster recovery |
| Deployment Engineer | `voltagent-infra:deployment-engineer` | CI/CD pipelines, deployment automation strategies |
| DevOps Engineer | `voltagent-infra:devops-engineer` | Infrastructure automation, containers, deployment |
| DevOps Incident Responder | `voltagent-infra:devops-incident-responder` | Active incidents, failures, postmortems |
| Docker Expert | `voltagent-infra:docker-expert` | Container images, orchestration, production hardening |
| Incident Responder | `voltagent-infra:incident-responder` | Security breaches, outages, evidence preservation |
| Kubernetes Specialist | `voltagent-infra:kubernetes-specialist` | K8s cluster design, deployment, troubleshooting |
| Network Engineer | `voltagent-infra:network-engineer` | Cloud/hybrid networks, security, performance |
| Platform Engineer | `voltagent-infra:platform-engineer` | Internal developer platforms, golden paths, self-service |
| Security Engineer | `voltagent-infra:security-engineer` | Security automation, zero-trust, vulnerability management |
| SRE Engineer | `voltagent-infra:sre-engineer` | SLO/SLI frameworks, error budgets, chaos engineering |
| Terraform Engineer | `voltagent-infra:terraform-engineer` | Terraform IaC, multi-cloud modules, state management |
| Terragrunt Expert | `voltagent-infra:terragrunt-expert` | Terragrunt DRY configurations, multi-env orchestration |
| Windows Infra Admin | `voltagent-infra:windows-infra-admin` | Windows Server, AD, DNS, DHCP, Group Policy |

**M3Dev Use Cases:**
- `docker-expert` — Optimize RunPod container images
- `kubernetes-specialist` — K8s deployment for ML workloads
- `terraform-engineer` — Infrastructure as code for cloud resources
- `sre-engineer` — Define SLOs for inference API reliability
- `devops-engineer` — CI/CD for model deployment pipelines

---

## voltagent-lang (26 Agents)

Language and framework specialists for implementation.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| Angular Architect | `voltagent-lang:angular-architect` | Angular 15+ enterprise apps, RxJS, micro-frontends |
| C++ Pro | `voltagent-lang:cpp-pro` | C++20/23, template metaprogramming, systems programming |
| C# Developer | `voltagent-lang:csharp-developer` | ASP.NET Core, Entity Framework, clean architecture |
| Django Developer | `voltagent-lang:django-developer` | Django 4+, REST APIs, async views |
| .NET Core Expert | `voltagent-lang:dotnet-core-expert` | .NET Core cloud-native, microservices, minimal APIs |
| .NET Framework 4.8 | `voltagent-lang:dotnet-framework-4.8-expert` | Legacy .NET Framework enterprise maintenance |
| Elixir Expert | `voltagent-lang:elixir-expert` | OTP, GenServer, Phoenix real-time |
| Flutter Expert | `voltagent-lang:flutter-expert` | Flutter 3+ cross-platform mobile/web |
| Go Pro | `voltagent-lang:golang-pro` | Concurrent Go, microservices, cloud-native |
| Java Architect | `voltagent-lang:java-architect` | Enterprise Java, Spring Boot microservices |
| JavaScript Pro | `voltagent-lang:javascript-pro` | ES2023+, async patterns, Node.js, full-stack JS |
| Kotlin Specialist | `voltagent-lang:kotlin-specialist` | Kotlin coroutines, multiplatform, Android |
| Laravel Specialist | `voltagent-lang:laravel-specialist` | Laravel 10+, Eloquent, queues, API optimization |
| Next.js Developer | `voltagent-lang:nextjs-developer` | Next.js 14+ App Router, server components, SEO |
| PHP Pro | `voltagent-lang:php-pro` | PHP 8.3+, Laravel/Symfony, strict typing |
| PowerShell 5.1 Expert | `voltagent-lang:powershell-5.1-expert` | Windows automation, RSAT, AD/DNS/DHCP management |
| PowerShell 7 Expert | `voltagent-lang:powershell-7-expert` | Cross-platform PS7, Azure automation, CI/CD |
| Python Pro | `voltagent-lang:python-pro` | Type-safe Python, async, FastAPI, production code |
| Rails Expert | `voltagent-lang:rails-expert` | Rails + Hotwire, real-time features |
| React Specialist | `voltagent-lang:react-specialist` | React 18+ optimization, advanced state management |
| Rust Engineer | `voltagent-lang:rust-engineer` | Memory safety, ownership, zero-cost abstractions |
| Spring Boot Engineer | `voltagent-lang:spring-boot-engineer` | Spring Boot 3+, cloud-native, reactive programming |
| SQL Pro | `voltagent-lang:sql-pro` | Query optimization across PostgreSQL/MySQL/Oracle |
| Swift Expert | `voltagent-lang:swift-expert` | Native iOS/macOS, async/await, SwiftUI |
| TypeScript Pro | `voltagent-lang:typescript-pro` | Advanced types, generics, full-stack type safety |
| Vue Expert | `voltagent-lang:vue-expert` | Vue 3, Composition API, Nuxt 3 |

**M3Dev Use Cases:**
- `python-pro` — Production Python for ML scripts and APIs
- `typescript-pro` — TypeScript type safety in frontend projects
- `rust-engineer` — Performance-critical inference components
- `golang-pro` — High-throughput API gateway services
- `nextjs-developer` — ML dashboard and admin panel frontend

---

## voltagent-qa-sec (14 Agents)

Quality assurance, security, testing, and debugging specialists.

| Agent | `subagent_type` | Best For |
|-------|----------------|----------|
| Accessibility Tester | `voltagent-qa-sec:accessibility-tester` | WCAG compliance, assistive technology testing |
| AD Security Reviewer | `voltagent-qa-sec:ad-security-reviewer` | Active Directory security, privilege escalation risks |
| Architect Reviewer | `voltagent-qa-sec:architect-reviewer` | System design review, architectural pattern evaluation |
| Chaos Engineer | `voltagent-qa-sec:chaos-engineer` | Failure experiments, resilience validation, game days |
| Code Reviewer | `voltagent-qa-sec:code-reviewer` | Code quality, bugs, security, best practices review |
| Compliance Auditor | `voltagent-qa-sec:compliance-auditor` | GDPR, HIPAA, PCI DSS, SOC 2, ISO compliance |
| Debugger | `voltagent-qa-sec:debugger` | Root cause analysis, error logs, stack traces |
| Error Detective | `voltagent-qa-sec:error-detective` | Cross-service error correlation, root cause identification |
| Penetration Tester | `voltagent-qa-sec:penetration-tester` | Authorized security testing, vulnerability exploitation |
| Performance Engineer | `voltagent-qa-sec:performance-engineer` | Bottleneck identification, profiling, optimization |
| PS Security Hardening | `voltagent-qa-sec:powershell-security-hardening` | PowerShell automation security, least-privilege |
| QA Expert | `voltagent-qa-sec:qa-expert` | QA strategy, test planning, quality metrics |
| Security Auditor | `voltagent-qa-sec:security-auditor` | Comprehensive security audits, compliance assessment |
| Test Automator | `voltagent-qa-sec:test-automator` | Test frameworks, scripts, CI/CD test integration |

**M3Dev Use Cases:**
- `code-reviewer` — Review PRs for ML platform code
- `security-auditor` — Audit inference API security
- `performance-engineer` — Profile and optimize inference endpoints
- `test-automator` — Build automated test suites for ML pipelines

---

## Agent Invocation Patterns

### Direct Task Tool Invocation
```python
# In Claude's reasoning, agents are invoked like:
Task(
    subagent_type="voltagent-infra:docker-expert",
    prompt="Optimize the RunPod inference container for A100 GPUs,
            minimize image size, and improve startup time"
)
```

### Parallel Agent Execution
Multiple independent agents run simultaneously:
- `voltagent-lang:python-pro` writing the API
- `voltagent-infra:docker-expert` optimizing the container
- `voltagent-qa-sec:test-automator` writing tests

### When Claude Auto-Invokes Agents

Claude selects agents based on the task description:

| You Ask | Agent Invoked |
|---------|--------------|
| "Review this code" | `voltagent-qa-sec:code-reviewer` |
| "Debug this error" | `voltagent-qa-sec:debugger` |
| "Set up K8s deployment" | `voltagent-infra:kubernetes-specialist` |
| "Write Python API" | `voltagent-lang:python-pro` |
| "Design the database" | `voltagent-data-ai:database-optimizer` |
| "Build ML pipeline" | `voltagent-data-ai:ml-engineer` |

---

## M3Dev Priority Agents

### Tier 1 (Daily Use)
- `voltagent-lang:python-pro` — Primary development language
- `voltagent-qa-sec:code-reviewer` — Code review and quality
- `voltagent-infra:docker-expert` — Container optimization
- `voltagent-data-ai:llm-architect` — LLM system design

### Tier 2 (Regular Use)
- `voltagent-infra:terraform-engineer` — Infrastructure as code
- `voltagent-infra:devops-engineer` — CI/CD pipelines
- `voltagent-data-ai:mlops-engineer` — ML lifecycle management
- `voltagent-lang:typescript-pro` — Frontend type safety
- `voltagent-lang:nextjs-developer` — Dashboard development

### Tier 3 (Periodic Use)
- `voltagent-infra:kubernetes-specialist` — K8s deployments
- `voltagent-infra:sre-engineer` — Reliability engineering
- `voltagent-qa-sec:performance-engineer` — Performance profiling
- `voltagent-qa-sec:security-auditor` — Security reviews
- `voltagent-data-ai:data-engineer` — Data pipeline work
