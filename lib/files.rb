class File

  def File.size(path)
    if File.file? (path)
      byte = File.stat(path).size
      for i in ['B','KB','MB','GB','TB']
        if byte > 1024.0
          byte /= 1024.0
        else
          return "%3.2f %s" % [byte, i]
        end
      end
    end
  end
end


