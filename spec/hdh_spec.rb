require 'pry'
require 'hdh'

def exp(h, s)
  it { expect(Hdh.render(h)).to eq(s) }
  it { expect(Hdh::Base.new.render(h)).to eq(s) }
end

describe Hdh do
  context '#render' do
    exp([:script], '<script></script>')
    exp([:p, "foo"], '<p>foo</p>')
    exp([:p, [:em, "foo"]], '<p><em>foo</em></p>')
    exp([:span, {class: "foo"}, "bar"], '<span class="foo">bar</span>')
    exp([:div, {id: "email", class: "selected starred"}, "..."], '<div id="email" class="selected starred">...</div>')
    exp([:a, {href: "google.com"}, "GitHub"], '<a href="google.com">GitHub</a>')

    context 'closes void tags' do
      exp([:br], '<br />')
      exp([:link], '<link />')
      exp([:div, [:p], [:br]], '<div><p></p><br /></div>')
    end

    context 'css shorthand' do
      exp(['p.hi', "foo"], '<p class="hi">foo</p>')
      exp(['p#hi', "foo"], '<p id="hi">foo</p>')
      exp(['p.hi.greet.left', "foo"], '<p class="hi greet left">foo</p>')
      exp(['p.greet.left#hi', "foo"], '<p id="hi" class="greet left">foo</p>')
    end

    context 'different shaped trees' do
      exp([:p, "Foo ", [:em, "World!"]], '<p>Foo <em>World!</em></p>')
      exp([:div, [:p, "Foo"], [:em, "World!"]], '<div><p>Foo</p><em>World!</em></div>')
    end
  end
end
