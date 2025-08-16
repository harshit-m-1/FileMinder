#! /usr/bin/bash

source_dir="$1"
destination_dir="$2"


# unzipping the zip file 
find $source_dir -name *.zip | while read -r zip_file; do
    unzip $zip_file -d $source_dir
    rm $zip_file
    clear
done

#1)------------------------------------------------------>
# copy file as per extension
function move_all_files_as_per_ext()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            extension="${filename##*.}"
            if [ -d $2/$extension ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$extension/$file_only_name" ]; then
                    creation_date=$(stat -c %w "$filename" | awk '{print $1}')
                    file_only_name="$file_only_name""_""$creation_date"
                    cp $i $2/$extension/$file_only_name
                else
                    cp $i $2/$extension
                fi
                
            else
                mkdir $2/$extension
                cp $i $2/$extension
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_ext $i $2
        fi
    done
}

#2) ----------------------------------------------------------->
#copy as per extension with log file
function move_all_files_as_per_ext_with_log()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            extension="${filename##*.}"
            if [ -d $2/$extension ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$extension/$file_only_name" ]; then
                    creation_date=$(stat -c %w "$filename" | awk '{print $1}')
                    file_only_name="$file_only_name""_""$creation_date"
                    cp $i $2/$extension/$file_only_name
                else
                    cp $i $2/$extension
                fi
                local current_time=$(date +%T)
                echo "$i----------to--------- $2/$extension----------at---------$current_time" >> $3
            else
                mkdir $2/$extension
                cp $i $2/$extension
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$extension----------at---------$current_time" >> $3
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_ext_with_log $i $2 $3
        fi
    done
}

#3) ------------------------------------------------------------>
#copy file as per date
function move_all_files_as_per_date()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            creation_date=$(stat -c %w "$filename" | awk '{print $1}')
            if [ -d $2/$creation_date ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$creation_date/$file_only_name" ]; then
                    file_only_name="$file_only_name""_""$creation_date"
                    cp $i $2/$creation_date/$file_only_name
                else
                    cp $i $2/$creation_date
                fi
            else
                mkdir $2/$creation_date
                cp $i $2/$creation_date
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_date $i $2
        fi
    done
}

#4) ----------------------------------------------------------->
#copy as per date with log file
function move_all_files_as_per_date_with_log()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            creation_date=$(stat -c %w "$filename" | awk '{print $1}')
            if [ -d $2/$creation_date ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$creation_date/$file_only_name" ]; then
                    file_only_name="$file_only_name""_""$creation_date"
                    cp $i $2/$creation_date/$file_only_name
                else
                    cp $i $2/$creation_date
                fi
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$creation_date----------at---------$current_time" >> $3
            else
                mkdir $2/$creation_date
                cp $i $2/$creation_date
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$creation_date----------at---------$current_time" >> $3
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_date_with_log $i $2 $3
        fi
    done
}

#5) -------------------------------------------------------->
#move file as per extension i.e. delete after move
function move_all_files_as_per_ext2()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            extension="${filename##*.}"
            if [ -d $2/$extension ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$extension/$file_only_name" ]; then
                    creation_date=$(stat -c %w "$filename" | awk '{print $1}')
                    file_only_name="$file_only_name""_""$creation_date"
                    mv $i $2/$extension/$file_only_name
                else
                    mv $i $2/$extension
                fi
            else
                mkdir $2/$extension
                mv $i $2/$extension
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_ext2 $i $2
        fi
    done
}

#6) --------------------------------------------------->
#move file as per extension with log file i.e. delete after move
function move_all_files_as_per_ext2_with_log()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            extension="${filename##*.}"
            if [ -d $2/$extension ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$extension/$file_only_name" ]; then
                    creation_date=$(stat -c %w "$filename" | awk '{print $1}')
                    file_only_name="$file_only_name""_""$creation_date"
                    mv $i $2/$extension/$file_only_name
                else
                    mv $i $2/$extension
                fi
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$extension----------at---------$current_time" >> $3
            else
                mkdir $2/$extension
                mv $i $2/$extension
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$extension----------at---------$current_time" >> $3
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_ext2_with_log $i $2 $3
        fi
    done
}

#7) ----------------------------------------------------->
#move file as per date i.e. delete after move
function move_all_files_as_per_date2()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            creation_date=$(stat -c %w "$filename" | awk '{print $1}')
            if [ -d $2/$creation_date ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$creation_date/$file_only_name" ]; then
                    file_only_name="$file_only_name""_""$creation_date"
                    mv $i $2/$creation_date/$file_only_name
                else
                    mv $i $2/$creation_date
                fi
            else
                mkdir $2/$creation_date
                mv $i $2/$creation_date
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_date2 $i $2
        fi
    done
}

#8) --------------------------------------------------------->
#move file as per date with log file i.e. delete after move
function move_all_files_as_per_date2_with_log()
{
    for i in $1/*
    do
        if [ -f $i ]
        then
            filename="$i"
            creation_date=$(stat -c %w "$filename" | awk '{print $1}')
            if [ -d $2/$creation_date ]
            then
                file_only_name=$(basename "$filename")
                if [ -f "$2/$creation_date/$file_only_name" ]; then
                    file_only_name="$file_only_name""_""$creation_date"
                    mv $i $2/$creation_date/$file_only_name
                else
                    mv $i $2/$creation_date
                fi
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$creation_date----------at---------$current_time" >> $3
            else
                mkdir $2/$creation_date
                mv $i $2/$creation_date
                local current_time=$(date +%T)
                echo "$i----------to---------$2/$creation_date----------at---------$current_time" >> $3
            fi
        elif [ -d $i ]
        then
            move_all_files_as_per_date2_with_log $i $2 $3
        fi
    done
}
# ---------------------------------------------------------------->

shift 2


# cases as per option given by user
delete_flag=0
log_file_flag=0
while getopts "l:ds:e:" opt; 
do
  case ${opt} in
    l)
        name_of_log_file=$OPTARG
        log_file_flag=1
        ;;
    d)
        delete_flag=1
        ;;
    s)
        if [ $OPTARG = "ext" ]
        then
            if [ $log_file_flag == 0 ]
            then  
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_ext $source_dir $destination_dir 
              else
                  move_all_files_as_per_ext2 $source_dir $destination_dir
              fi
            elif [ $log_file_flag == 1 ]
            then
              touch $destination_dir/$name_of_log_file.log
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_ext_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              else
                  move_all_files_as_per_ext2_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              fi
            fi
        elif [ $OPTARG = "date" ]
        then
            if [ $log_file_flag == 0 ]
            then
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_date $source_dir $destination_dir
              else
                  move_all_files_as_per_date2 $source_dir $destination_dir
              fi
            elif [ $log_file_flag == 1 ]
            then
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_date_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              else
                  move_all_files_as_per_date2_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              fi
            fi
        else
            if [ $log_file_flag == 0 ]
            then
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_ext $source_dir $destination_dir 
              else
                  move_all_files_as_per_ext2 $source_dir $destination_dir
              fi
            elif [ $log_file_flag == 1 ]
            then
              touch $destination_dir/$name_of_log_file.log
              if [ $delete_flag == 0 ]
              then
                  move_all_files_as_per_ext_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              else
                  move_all_files_as_per_ext2_with_log $source_dir $destination_dir $destination_dir/$name_of_log_file.log
              fi
            fi
        fi
        ;;
    e)
        IFS=',' read -ra values <<< "$OPTARG"   # Split comma-separated values into an array
        ;;
    \?)
        echo "Invalid option"
        ;;
  esac
done

#if no option is given i.e. default case
if [[ $OPTIND == 1 ]]; then
    move_all_files_as_per_ext $source_dir $destination_dir
fi


# counting number of files and folder
destination_folder_flag=0
find $destination_dir -type d -mmin -1 | while read -r folder; do
    if [ $destination_folder_flag == 0 ] 
    then
        no_of_folder=$(ls $folder | wc -w)
        echo "Total number of folder created is: $(( no_of_folder-1 ))"
        destination_folder_flag=1
    else
        no_of_file=$(ls $folder | wc -w)
        echo "$folder has $no_of_file files"
    fi
done


