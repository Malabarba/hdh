module Hdh::Helpers
  def render(h)
    return escape(h) unless h.is_a?(Array)

    h.any? ? render_tag(h) : ''
  end

  alias html render

  private

  VOID_ELEMENTS = %i[area base br col embed hr img input link meta param source track wbr].freeze

  def render_tag(h)
    t, *cs = h
    attrs, *cs = cs if cs.first.is_a?(Hash)
    t, attrs = parse_shorthands(t, attrs)

    opening = "#{t}#{render_tag_attributes(attrs)}"
    if VOID_ELEMENTS.include?(t.to_sym) ||
       (cs.empty? && t =~ /^[A-Z]/)
      "<#{opening} />"
    else
      "<#{opening}>#{cs.map(&r).join}</#{t}>"
    end
  end

  def parse_shorthands(t, attrs)
    attrs = attrs&.dup || {}
    _, tcl, id = /([^#]+)(?:#([^#]+))?/.match(t)&.to_a
    raise ArgumentError, "Invalid HTML tag: #{t}" unless tcl

    attrs[:id] = id if id
    t, *cl = tcl.split('.')
    attrs[:class] = Array(attrs[:class]) + cl if cl.any?
    [t || :div, attrs]
  end

  def render_tag_attributes(attrs, prefix: '')
    return '' unless attrs

    attrs.map do |k, v|
      case v
      when Hash
        render_tag_attributes(v, prefix: "#{prefix}#{k}-")
      when Array
        " #{k}=\"#{v.map(&method(:escape)).join(' ')}\""
      else
        " #{k}=\"#{escape(v)}\""
      end
    end.join
  end

  def escape(s)
    case s
    when String then s
    else s.to_s
    end
  end

  def r
    method(:render)
  end
end
