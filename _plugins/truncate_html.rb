require 'truncato'

module Jekyll
  module TruncateHTMLFilter
    DEFAULT_OPTIONS = {
      max_length: 140,
      count_tags: false,
      tail: "\u2026",
      count_tail: false,
      comments: false,
      filtered_attributes: [],
      filtered_tags: []
    }.freeze


    def truncate_html(source)
      options = DEFAULT_OPTIONS.merge(user_options) do |key, oldval, newval|
        if newval
          newval
        else
          oldval
        end
      end
      Truncato::truncate(source, options)
    end

    private

    def user_options
      return @options if @options

      config = @context.registers[:site].config["auto_excerpt"] || {}
      @options = {
        max_length: config["max_length"],
        count_tags: config["count_tags"],
        tail: config["tail"],
        count_tail: config["count_tail"],
        comments: config["comments"],
        filtered_attributes: config["exclude_attributes"],
        filtered_tags: config["exclude_tags"]
      }
    end
  end
end

Liquid::Template.register_filter(Jekyll::TruncateHTMLFilter)
