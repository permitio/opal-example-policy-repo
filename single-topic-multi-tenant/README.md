# Single-Topic Multi-Tenant RBAC Example

This directory contains a single-topic multi-tenant RBAC policy example for OPAL.

## Architecture

Traditional multi-tenant OPAL setups require:
- **N tenants = N topics** (each tenant has its own topic)
- **Service restarts** when adding new tenants
- **Complex topic management**

This example demonstrates a revolutionary approach:
- **N tenants = 1 topic + N data sources** 
- **Zero restarts** when adding tenants
- **Dynamic tenant addition** via `/data/config` API

## How it works

1. **Single Topic**: All tenants share one topic `tenant_data`
2. **External Data Sources**: Each tenant has its own data source configured via API
3. **Data Isolation**: Tenants are isolated through OPA path hierarchy (`/acl/tenant1`, `/acl/tenant2`)
4. **Policy Sharing**: All tenants use the same RBAC policy logic

## Policy Structure

- `rbac.rego` - RBAC policy compatible with older OPA versions (no "if" statements)
- `data.json` - Demo data showing expected structure
- `.manifest` - Load order specification

## Data Structure

The policy expects data at paths like `/acl/{tenant_id}`:

```json
{
  "acl": {
    "tenant1": {
      "users": {
        "alice": {
          "roles": ["admin"],
          "location": "US"
        }
      },
      "role_permissions": {
        "admin": [
          {"action": "*", "resource": "*"}
        ]
      }
    }
  }
}
```

## Usage with OPAL

1. Configure OPAL Server to use this policy repo
2. Add tenants dynamically via External Data Sources API:

```bash
curl -X POST http://opal-server:7002/data/config \
  -H "Content-Type: application/json" \
  -d '{
    "id": "tenant1_data",
    "entries": [{
      "url": "http://data-source/tenant1/data",
      "topics": ["tenant_data"],
      "dst_path": "/acl/tenant1"
    }]
  }'
```

3. No service restart required!

## Compatibility

This policy is written in older OPA syntax for maximum compatibility:
- Uses `some` keyword for quantification
- No `if` statements
- Compatible with OPA versions prior to v0.20.0

## Testing

Query examples:
```json
{
  "user": "alice",
  "action": "read",
  "resource": "documents"
}
```

Expected result for admin user: `{"result": true}` 