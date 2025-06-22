class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer

  # https://github.com/palkan/view_component-contrib?tab=readme-ov-file#style-variants
  include ViewComponentContrib::StyleVariants

  private

  def tw_merge(*inputs)
    TailwindMerge::Merger.new.merge(inputs.join(" "))
  end
end
