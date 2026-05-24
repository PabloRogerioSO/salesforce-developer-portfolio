# Salesforce Developer Portfolio — Client Weather Insights

A modern, cloud-integrated Salesforce application built using enterprise development practices. This repository showcases a hybrid architecture (Programmatic + Declarative) featuring a Lightning Web Component (LWC) that consumes an external REST API via an Apex controller layer.

## 🚀 Project Overview

The **Account Weather Insights** component is designed for B2B sales teams. It dynamically captures the `BillingCity` from an Account record page and fetches real-time weather metrics using a third-party weather service. This provides immediate environmental context to account executives right before client interactions.

### ⚙️ Architecture & Technical Highlights

* **Apex Backend Integration:** Implements a robust `Http` callout pattern optimized with `@AuraEnabled(cacheable=true)` for client-side UI caching and lightning-fast performance.
* **Security First (Named Credentials):** Architecture abstracts sensitive endpoints and API tokens out of the codebase using Salesforce **Named Credentials**, enforcing security compliance and ensuring no raw keys are leaked to version control.
* **Reactive LWC:** Built using ES6+ JavaScript, utilizing native Lightning Data Service (`@wire`) field adapters to ensure automatic interface updates when record data changes.
* **Robust Exception Handling:** Gracefully handles communication timeouts and bad API requests by catching server-side errors and surfacing them safely via customized `AuraHandledException` alerts on the UI.
* **Enterprise Testing Design:** Tested via an asynchronous Mock framework (`HttpCalloutMock`) ensuring 100% test coverage across success paths and negative error-injection boundaries without breaking Salesforce governor execution rules.

## 🛠️ Tech Stack & Tools

* **Salesforce Platform:** Apex, Lightning Web Components (LWC), Salesforce CLI (`sf`)
* **Frontend:** HTML5, Modern JavaScript (ES6+), Salesforce Lightning Design System (SLDS)
* **Quality Assurance:** Apex Unit Testing (Mocking Framework)
* **DevOps / Version Control:** Git, GitHub, Conventional Commits standard

## 📦 Repository Structure

```text
├── force-app/main/default/
│   ├── classes/
│   │   ├── AccountWeatherController.cls        # Main integration logic
│   │   ├── AccountWeatherMock.cls              # HTTP Mock for test isolation
│   │   └── AccountWeatherControllerTest.cls    # 100% coverage unit tests
│   └── lwc/
│       └── accountWeather/                     # UI Web Component (HTML/JS/XML)