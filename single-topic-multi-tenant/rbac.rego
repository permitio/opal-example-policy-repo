# Multi-Tenant Role-based Access Control (RBAC)
# Single-Topic Multi-Tenant Architecture Example
# Compatible with older OPA versions (no "if" statements)

package rbac

import data.acl

# By default, deny requests
default allow = false

# Allow admin users to do anything
allow {
    user_is_admin
}

# Allow users based on role permissions
allow {
    # Find tenant data for this request
    some tenant_id
    tenant_data := acl[tenant_id]
    
    # Check if user exists in tenant data
    user_data := tenant_data.users[input.user]
    
    # Get user's roles from tenant data
    some role
    role := user_data.roles[_]
    
    # Get permissions for this role from tenant data
    permissions := tenant_data.role_permissions[role]
    
    # Check if role has permission for this action/resource
    some permission
    permission := permissions[_]
    permission.action == input.action
    permission.resource == input.resource
    
    # Check location restriction (OPAL example compatibility)
    user_data.location == "US"
}

# Helper rule to check if user is admin
user_is_admin {
    some tenant_id
    tenant_data := acl[tenant_id]
    user_data := tenant_data.users[input.user]
    some role
    role := user_data.roles[_]
    role == "admin"
} 