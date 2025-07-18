class ApplicationViewComponent < ViewComponentContrib::Base
  extend Dry::Initializer

  # https://github.com/palkan/view_component-contrib?tab=readme-ov-file#style-variants
  include ViewComponentContrib::StyleVariants
  include ApplicationHelper
  include Turbo::FramesHelper

  private

  def controller_name
    self.class.name.underscore.tr("_", "-").gsub("/", "--")
  end

  def tw_merge(*inputs)
    TailwindMerge::Merger.new.merge(inputs.join(" "))
  end
end
