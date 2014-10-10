# encoding: UTF-8
#
# Cookbook Name:: openstack-orchestration
# Attributes:: default
#
# Copyright 2013, IBM Corp.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default['openstack']['orchestration']['custom_template_banner'] = '
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
'

default['openstack']['orchestration']['verbose'] = 'False'
default['openstack']['orchestration']['debug'] = 'False'
# This is the name of the Chef role that will install the Keystone Service API
default['openstack']['orchestration']['identity_service_chef_role'] = 'os-identity'

# Gets set in the Heat Endpoint when registering with Keystone
default['openstack']['orchestration']['region'] = node['openstack']['region']

# The name of the Chef role that knows about the message queue server
# that Heat uses
default['openstack']['orchestration']['rabbit_server_chef_role'] = 'os-ops-messaging'

default['openstack']['orchestration']['service_tenant_name'] = 'service'
default['openstack']['orchestration']['service_user'] = 'heat'
default['openstack']['orchestration']['service_role'] = 'admin'

default['openstack']['orchestration']['api']['auth']['version'] = node['openstack']['api']['auth']['version']

# A PEM encoded Certificate Authority to use for clients when verifying HTTPs connections.
default['openstack']['orchestration']['clients']['ca_file'] = nil
# Cert file to use for clients when verifying HTTPs connections.
default['openstack']['orchestration']['clients']['cert_file'] = nil
# Private key file to use for clients when verifying HTTPs connections.
default['openstack']['orchestration']['clients']['key_file'] = nil
# Whether to allow insecure SSL (https) requests when calling clients.
default['openstack']['orchestration']['clients']['insecure'] = false

# A list of memcached server(s) for caching
default['openstack']['orchestration']['api']['auth']['memcached_servers'] = nil

# Whether token data should be authenticated or authenticated and encrypted. Acceptable values are MAC or ENCRYPT
default['openstack']['orchestration']['api']['auth']['memcache_security_strategy'] = nil

# This string is used for key derivation
default['openstack']['orchestration']['api']['auth']['memcache_secret_key'] = nil

# Hash algorithms to use for hashing PKI tokens
default['openstack']['orchestration']['api']['auth']['hash_algorithms'] = 'md5'

# A PEM encoded Certificate Authority to use when verifying HTTPs connections
default['openstack']['orchestration']['api']['auth']['cafile'] = nil

# Whether to allow the client to perform insecure SSL (https) requests
default['openstack']['orchestration']['api']['auth']['insecure'] = false

# Keystone role for heat template-defined users. (string value)
default['openstack']['orchestration']['heat_stack_user_role'] = nil

# Keystone domain name which contains heat template-defined users. (string value)
default['openstack']['orchestration']['stack_user_domain_name'] = nil

# Keystone username, a user with roles sufficient to manage
# users and projects in the stack_user_domain. (string value)
default['openstack']['orchestration']['stack_domain_admin'] = nil

# If set, heat API service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api']['bind_interface'] = nil

# If set, heat api-cfn service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api-cfn']['bind_interface'] = nil

# If set, heat api-cloudwatch service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api-cloudwatch']['bind_interface'] = nil

# Keystone PKI signing directory. Only written to the filter:authtoken section
# of the api-paste.ini when node['openstack']['auth']['strategy'] == 'pki'
default['openstack']['orchestration']['api']['auth']['cache_dir'] = '/var/cache/heat'

# logging attribute
default['openstack']['orchestration']['syslog']['use'] = false
default['openstack']['orchestration']['syslog']['facility'] = 'LOG_LOCAL2'
default['openstack']['orchestration']['syslog']['config_facility'] = 'local2'

# Common rpc definitions
default['openstack']['orchestration']['rpc_thread_pool_size'] = 64
default['openstack']['orchestration']['rpc_conn_pool_size'] = 30
default['openstack']['orchestration']['rpc_response_timeout'] = 60

# Notification definitions
default['openstack']['orchestration']['notification_driver'] = 'heat.openstack.common.notifier.rpc_notifier'
default['openstack']['orchestration']['default_notification_level'] = 'INFO'
default['openstack']['orchestration']['default_publisher_id'] = ''
default['openstack']['orchestration']['list_notifier_drivers'] = 'heat.openstack.common.notifier.no_op_notifier'
default['openstack']['orchestration']['notification_topics'] = 'notifications'

# Array of options for `heat.conf` (e.g. ['option1=value1', 'option2=value2'])
default['openstack']['orchestration']['misc_heat'] = nil

# platform-specific settings
case platform_family
when 'fedora', 'rhel' # :pragma-foodcritic: ~FC024 - won't fix this
  default['openstack']['orchestration']['user'] = 'heat'
  default['openstack']['orchestration']['group'] = 'heat'
  default['openstack']['orchestration']['platform'] = {
    'heat_common_packages' => ['openstack-heat'],
    'heat_client_packages' => ['python-heatclient'],
    'heat_api_packages' => ['python-heatclient'],
    'heat_api_service' => 'openstack-heat-api',
    'heat_api_cfn_packages' => ['python-heatclient'],
    'heat_api_cfn_service' => 'openstack-heat-api-cfn',
    'heat_api_cloudwatch_packages' => ['python-heatclient'],
    'heat_api_cloudwatch_service' => 'openstack-heat-api-cloudwatch',
    'heat_engine_packages' => [],
    'heat_engine_service' => 'openstack-heat-engine',
    'heat_api_process_name' => 'heat-api',
    'package_overrides' => ''
  }
when 'debian'
  default['openstack']['orchestration']['user'] = 'heat'
  default['openstack']['orchestration']['group'] = 'heat'
  default['openstack']['orchestration']['platform'] = {
    'heat_common_packages' => ['heat-common'],
    'heat_client_packages' => ['python-heatclient'],
    'heat_api_packages' => ['heat-api', 'python-heatclient'],
    'heat_api_service' => 'heat-api',
    'heat_api_cfn_packages' => ['heat-api-cfn', 'python-heatclient'],
    'heat_api_cfn_service' => 'heat-api-cfn',
    'heat_api_cloudwatch_packages' => ['heat-api-cloudwatch', 'python-heatclient'],
    'heat_api_cloudwatch_service' => 'heat-api-cloudwatch',
    'heat_engine_packages' => ['heat-engine'],
    'heat_engine_service' => 'heat-engine',
    'package_overrides' => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end
