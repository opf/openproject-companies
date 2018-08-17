class ConvertTextileToMarkdown < ActiveRecord::Migration[5.1]
  def up
    converter = OpenProject::TextFormatting::Formats::Markdown::TextileConverter.new
    cs = Setting.where(name: "plugin_openproject_companies").first

    if cs
      new_value = cs
        .value
        .select { |k, v| k =~ /(top|bottom)_text/ }
        .map { |k, v| [k, converter.send(:convert_textile_to_markdown, v)] }
        .to_h

      cs.update value: cs.value.merge(new_value)
    end
  end
end
