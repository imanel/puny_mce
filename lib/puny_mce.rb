module PunyMCE

  PROFILES = {
    :mini => {
      :toolbar => %w( bold italic underline strike ul ol removeformat ),
      :plugins => %w( Paste )
    },
    :web => {
      :toolbar => %w( bold italic underline strike ul ol left center right removeformat link unlink ),
      :plugins => %w( Paste Link )
    },
    :standard => {
      :toolbar => %w( bold italic underline strike ul ol left center right removeformat link unlink image ),
      :plugins => %w( Paste Image Link )
    },
    :full => {
      :toolbar => %w( bold italic underline strike increasefontsize decreasefontsize ul ol indent outdent left center right style textcolor removeformat link unlink image emoticons editsource ),
      :plugins => %w( BBCode Paste Image Emoticons Link ForceBlocks Protect TextColor EditSource Safari2x Entities ForceNL TabFocus )
    }
  }

  def puny_mce(name, id, options = {})
    page = "<script type='text/javascript'>"
    page << "var #{name} = new punymce.Editor({"
    page << "id : '#{id}'"

    profile = options[:profile]
    if profile && PROFILES.include?(profile)
      options[:toolbar] = PROFILES[profile][:toolbar]
      options[:plugins] = PROFILES[profile][:plugins]
    end

    page << "\n,toolbar : '#{options[:toolbar].join(",")}'" if options[:toolbar]
    page << "\n,plugins : '#{options[:plugins].join(",")}'" if options[:plugins]
    page << "\n,min_width : #{options[:min_width].to_i}" if options[:min_width]
    page << "\n,min_height : #{options[:min_height].to_i}" if options[:min_height]
    page << "\n,max_width : #{options[:max_width].to_i}" if options[:max_width]
    page << "\n,max_height : #{options[:max_height].to_i}" if options[:max_height]
    page << "\n,entities : '#{options[:entities]}'" if options[:entities]
    page << "\n,content_css : '#{options[:content_css]}'" if options[:content_css]
    page << "\n,editor_css : '#{options[:editor_css]}'" if options[:editor_css]
    page << "\n,entity_list : '#{options[:entity_list]}'" if options[:entity_list]
    if options[:styles]
      page << "\n,styles : ["
      options[:styles].each do |title, options|
        page << "\n{ title : '#{title}'"
        options.each do |key, value|
          page << ", #{key} : '#{value}'"
        end
        page << " },"
      end
      page << "\n]"
    end
    page << "});"
    page << "</script>"
  end

  def include_puny_mce(options = {})
    include_list = []
    profiles = options[:profiles].to_a
    unless profiles.empty?
      profiles.each do |profile|
        include_list += PROFILES[profile][:plugins] if PROFILES.include?(profile)
      end
    end
    include_list += options[:plugins].to_a
    include_list = include_list.uniq.compact
    include_array = ["punymce/puny_mce"]
    include_list.each do |inc|
      case inc
      when "BBCode" then include_array << "punymce/plugins/bbcode"
      when "Entities" then include_array << "punymce/plugins/entities"
      when "ForceBlocks" then include_array << "punymce/plugins/forceblocks"
      when "Paste" then include_array << "punymce/plugins/paste"
      when "Protect" then include_array << "punymce/plugins/protect"
      when "Safari2x" then include_array << "punymce/plugins/safari2x"
      when "TextColor" then include_array << "punymce/plugins/textcolor/textcolor"
      when "Image" then include_array << "punymce/plugins/image/image"
      when "Link" then include_array << "punymce/plugins/link/link"
      when "Emoticons" then include_array << "punymce/plugins/emoticons/emoticons"
      when "EditSource" then include_array << "punymce/plugins/editsource/editsource"
      end
    end
    include_array << "punymce/i18n/#{options[:lang].to_s}" if options[:lang]
    javascript_include_tag include_array
  end

end
