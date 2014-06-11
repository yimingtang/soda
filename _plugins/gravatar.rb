require 'digest/md5'

module Jekyll
  module GravatarFilter
    def gravatar(email_address, gravatar_mode=nil)
      @gravatar_mode = gravatar_mode
      email_address ||= ""
      return "<img class=\"gravatar\" src=\"#{gravatar_url(email_address)}\"></img>"
    end

    private

    def gravatar_url(email_address)
      url = "#{gravatar_protocol}://www.gravatar.com/avatar/#{gravatar_hash(email_address)}"
      url += "?" + gravatar_options.join('&') unless gravatar_options.empty?
      url
    end

    def gravatar_protocol
      protocol = gravatar_config["secure"] ? "https" : "http"
    end

    def gravatar_hash(email_address)
      hash = Digest::MD5.hexdigest(email_address.downcase.gsub(/\s+/, ""))
    end

    def gravatar_config
      return @gravatar_config if @gravatar_config

      @gravatar_config = Jekyll.configuration({})['gravatar'] || {}

      unless @gravatar_config.empty?
        mode_config = (@gravatar_mode and @gravatar_config[@gravatar_mode]) ? @gravatar_config[@gravatar_mode] : @gravatar_config
        @gravatar_config = @gravatar_config.merge mode_config
      end
      @gravatar_config
    end

    def gravatar_options
      opts = []
      opts.push "s=#{gravatar_config['size']}" if gravatar_config["size"]
      opts.push "r=#{gravatar_config['rating']}" if gravatar_config["rating"]
      opts.push "d=#{gravatar_config['default_image']}" if gravatar_config["default_image"]
      opts.push "f=#{gravatar_config['force']}" if gravatar_config['force']
      opts
    end
  end
end
Liquid::Template.register_filter(Jekyll::GravatarFilter)
