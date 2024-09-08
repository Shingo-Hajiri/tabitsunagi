# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.base_uri    :self
    policy.font_src    :self, 'https://fonts.gstatic.com'
    policy.img_src     :self, 'https://*.googleapis.com', 'https://*.gstatic.com',
                       '*.google.com', '*.googleusercontent.com',
                       'https://tabitsunagi-development.s3.ap-northeast-1.amazonaws.com',
                       'https://tabitsunagi-production.s3.ap-northeast-1.amazonaws.com', 'data:'
    # policy.object_src  :none
    policy.frame_src   '*.google.com'
    policy.connect_src :self, 'https://*.googleapis.com', '*.google.com', 'https://*.gstatic.com', 'data:', 'blob:', 'https://www.google-analytics.com', 'https://*.google-analytics.com'
    policy.script_src  :self, :strict_dynamic, -> { "'nonce-#{@csp_nonce}'" }, 'https://*.googleapis.com', 'https://*.gstatic.com', '*.google.com',
                       'https://*.ggpht.com', '*.googleusercontent.com', 'blob:'
    policy.style_src   :self, -> { "'nonce-#{@csp_nonce}'" }, 'https://fonts.googleapis.com'
    policy.worker_src  'blob:'
    # Specify URI for violation reports
    # policy.report_uri "/csp-violation-report-endpoint"
  end
#
# Generate session nonces for permitted importmap, inline scripts, and inline styles.
#   config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
#   config.content_security_policy_nonce_directives = %w(script-src style-src)
#
# Report violations without enforcing the policy.
# config.content_security_policy_report_only = true
end
