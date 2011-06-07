#sudo env ARCHFLAGS="-arch x86_32" gem install rb-appscript
    require 'rubygems'
    require 'appscript'

    target_names = ['MinitSample'] # Put your target names here
    group_name = 'objc'   # Name of Xcode project group where to add the generated files

    if  ENV["PROJECT_NAME"].nil? then 
      project_name = "MinitSample"
    else
      project_name = ENV["PROJECT_NAME"]
    end

    if  ENV["PROJECT_DIR"].nil? then
      project_dir = "/Users/adi/Desktop/apocope/dev/minit/MinitSample"
    else
      project_dir = ENV["PROJECT_DIR"]
    end

    xcode = Appscript.app('Xcode')
    project = xcode.projects[project_name]
    group = project.groups[group_name]
    group_path =  group.real_path.get
    generated_files = Dir.glob(group_path+"/*.m")
    missing_files = Array.new(generated_files)
    group.item_references.get.each {|item|
      item_path = item.real_path.get
      missing_files.delete(item_path)
      if ! generated_files.include?(item_path) then
        group.file_references[item.name.get].delete
        puts "Deleting #{File.basename(item_path)} from group #{group_name}, as it is not in generated files list"
      end
    }
    if missing_files.empty? then
      puts "There are no new files to add. "
      exit
    end
    # holds the compile targets for generated files
    targets = []
    project.targets.get.each{ |target|
      targets << target if target_names.include?(target.name.get)
    }
    if targets.empty? then
      puts "Unable to find #{target_names.inspect} in project targets ! Aborting"
      exit
    end
    missing_files.each{ |path|
      file_name = File.basename(path)
      msg = "Adding #{file_name} to group #{group_name} and to targets: "
      item = xcode.make(:new => :file_reference, 
                        :at => group.item_references.after, 
                        :with_properties => {:full_path => path,
                        :name => file_name})
      targets.each {|target|
          xcode.add(item,{:to=>target})
          msg += target.name.get
        }
        puts msg
    }
