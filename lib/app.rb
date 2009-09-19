module App
  module Controller
    module Accounts
      def self.included(controller)
        controller.helper_method(
          :current_account, 
          :account_domain, 
          :current_host,
          :account_subdomain, 
          :default_account_url,
          :default_account_subdomain,
          :current_account_owned_by?,
          :subdomain? )
      end

      protected

        def current_host
          request.host  
        end
        
        def current_account_owned_by?(user)
          current_account.owner_id == user.id
        end
        
        def current_account
          Account.find_by_subdomain(account_subdomain)
        end
        
        def default_account_subdomain
          account_subdomain if ["www", ""].include?(account_subdomain)
        end
        
        def default_account_url( use_ssl = request.ssl? )
          http_protocol(use_ssl) + account_domain
        end

        def account_subdomain
          #request.subdomains.first || ''
          current_subdomain #see subdomain_fu
        end
        
        def account_domain
          #account_domain = ''
          #account_domain << request.domain + request.port_string
          current_domain #see subdomain_fu
        end

        def subdomain?
          #request.subdomains
          current_subdomain #see subdomain_fu
        end

        def http_protocol( use_ssl = request.ssl? )
          (use_ssl ? "https://" : "http://")
        end
        
        # TODO: Make account_url and account_host methods work
        # def account_url(account_subdomain = default_account_subdomain, use_ssl = request.ssl?)
        #   http_protocol(use_ssl) + account_host(account_subdomain)
        # end
        # 
        # def account_host(subdomain)
        #   account_host = ''
        #   account_host << subdomain + '.'
        #   account_host << account_domain
        # end
    end
    module Users
      def self.included(controller)
        controller.helper_method(
          :current_user, 
          :current_user_session, 
          :require_user, 
          :require_no_user,  
          :redirect_back_or_default, 
          :created_by_current_user?, 
          :created_by_user?,
          :current_user?,
          :account_owner?)
      end
      
      protected
        
        def current_user?(user)
          current_user.id == user.id
        end
        
        def created_by_current_user?(object)
          object.user_id == current_user.id.to_s
        end
        
        def created_by_user?(object, user)
          object.user_id == user.id
        end

        def account_owner?
          current_user && current_user.id == current_account.owner_id
        end
        
        def require_account_owner
          unless current_user && current_user.id == current_account.owner_id
            store_location
            flash[:notice] = "You must be an account owner to access this page"
            redirect_to account_url
            return false
          end
        end
        
        def require_user
          unless current_user
            store_location
            flash[:notice] = "You must be logged in to access this page"
            redirect_to new_user_session_url
            return false
          end
        end
  
        def require_no_user
          if current_user
            store_location
            flash[:notice] = "You must be logged out to access this page"
            redirect_to account_url
            return false
          end
        end
  
        def owned_by_current_user?(object)
          true if object.user_id == current_user.id.to_s
        end
  
        def current_user
          return @current_user if defined?(@current_user)
          @current_user = current_user_session && current_user_session.record
        end
  
        def current_user_session
          return @current_user_session if defined?(@current_user_session)
          @current_user_session = current_account != nil ? current_account.user_sessions.find : nil
        end
        
        def store_location
          session[:return_to] = request.request_uri
        end
        
        def redirect_back_or_default(default)
          redirect_to(session[:return_to] || default)
          session[:return_to] = nil
        end
        
    end
  end
end
