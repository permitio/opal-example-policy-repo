<p  align="center">
 <img src="https://i.ibb.co/BGVBmMK/opal.png" height=170 alt="opal" border="0" />
</p>
<h2 align="center">
OPAL Example Policy Repo
</h2>

[Check out OPAL main repo here.](https://github.com/permitio/opal)

### What's in this repo?
This repo contain an example git repo containing a basic [OPA](https://www.openpolicyagent.org/docs/latest/) policy written in [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/#what-is-rego).

This repo is used in [OPAL](https://github.com/permitio/opal)'s Getting Started [tutorial](https://github.com/permitio/opal/blob/master/docs/HOWTO/get_started_with_opal_using_docker.md) to **demonstrate** how OPAL keeps your OPA agents in sync with policy and data changes. When commits are affecting this repo, the OPAL server will immediately push updates (over websockets pub/sub interface) to the connected OPAL clients, and they in turn will push the updated policy and data to OPA.

If you follow [the tutorial](https://github.com/permitio/opal/blob/master/docs/HOWTO/get_started_with_opal_using_docker.md), you will see how this repo is used by OPAL in a real example running in docker-compose. The entire tutorial is also available as [video](https://asciinema.org/a/5IMzZRPltUiFdsNnZ81t14ERk?t=1).

#### The policy in this repo
This repo has a very simple [RBAC policy](https://en.wikipedia.org/wiki/Role-based_access_control):
- each user is granted certain roles
- a user can perform an action on a resource, only if:
  - one of his roles has permission to do so
  - the user "location" is in the US (a special **twist** that is **non-standard** to RBAC, but is useful for the tutorial)
- a user with admin role can do anything

### About OPA (Open Policy Agent)

#### Why use OPA?
OPA enables decoupling policy from code in your applications, and enables you to evolve your application and your authorization policies (i.e: "permissions logic") separately.

#### Who uses OPA?
Companies like [Netflix](https://www.youtube.com/watch?v=R6tUNpRpdnY) and [Pinterest](https://www.youtube.com/watch?v=LhgxFICWsA8) built their authorization layer using OPA

### About OPAL (Open Policy Administration Layer)
[OPAL](https://github.com/permitio/opal) is an administration layer for Open Policy Agent (OPA), detecting changes to both policy and policy data in realtime and pushing live updates to your agents.

OPAL brings open-policy up to the speed needed by live applications. As your application state changes (whether it's via your APIs, DBs, git, S3 or 3rd-party SaaS services), OPAL will make sure your services are always in sync with the authorization data and policy they need (and only those they need).

Check out OPAL's main site at [OPAL.ac](https://opal.ac).

<img src="https://i.ibb.co/CvmX8rR/simplified-diagram-highlight.png" alt="simplified" border="0">
