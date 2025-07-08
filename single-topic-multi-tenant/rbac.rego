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
    tenant_data := acl[_]
    
    # Check if user exists in tenant data
    user_data := tenant_data.users[input.user]
    
    # Get user's roles from tenant data
    user_role := user_data.roles[_]
    
    # Get permissions for this role from tenant data
    permissions := tenant_data.role_permissions[user_role]
    
    # Check if role has permission for this action/resource
    user_permission := permissions[_]
    user_permission.action == input.action
    user_permission.resource == input.resource
    
    # Check location restriction (OPAL example compatibility)
    user_data.location == "US"
}

# Helper rule to check if user is admin
user_is_admin {
    tenant_data := acl[_]
    user_data := tenant_data.users[input.user]
    admin_role := user_data.roles[_]
    admin_role == "admin"
}

