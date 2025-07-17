# Multi-Tenant Role-based Access Control (RBAC)
# Single-Topic Multi-Tenant Architecture Example
# Compatible with older OPA versions (no "if" statements)
# USES EXPLICIT TENANT_ID for production security

package multi_tenant_rbac

import data.acl

# By default, deny requests
default allow = false

# Allow admin users to do anything
allow {
    user_is_admin
}

# Allow users based on role permissions with explicit tenant_id
allow {
    # Ensure tenant_id is provided in input
    input.tenant_id
    
    # Get tenant data using explicit tenant_id (secure and performant)
    tenant_data := acl[input.tenant_id]
    
    # Check if user exists in this specific tenant
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

# Helper rule to check if user is admin with explicit tenant_id
user_is_admin {
    # Ensure tenant_id is provided
    input.tenant_id
    
    # Get tenant data using explicit tenant_id
    tenant_data := acl[input.tenant_id]
    
    # Check if user exists and has admin role
    user_data := tenant_data.users[input.user]
    admin_role := user_data.roles[_]
    admin_role == "admin"
} 