######## git commit easy cmd ########

# Add = 向代码仓库中添加新的内容（feature, test等）
# Drop = 移除代码仓库中的内容（feature, test等）
# Fix = 修复代码仓库中存在的问题（bug，typo，misstatement等）
# Revert = 回滚历史的某条提交
# Make = 修改编译流程相关文件，工具等（例如Makefile，代码生成器等）
# Optimize = 修改只与性能优化相关
# Document = 修改只与文档/注释相关
# Refactor = 修改只能包含代码重构（不能新增/删除/修改任何API）
# Reformat = 修改只能包含代码格式的变化（使用格式化工具格式化代码等）
# Rearrange =  修改仅包含工程组织结构的变化
# Style = 更新UI和样式文件

emoji=false
uname=false

_std_commit() {
	if [[ $# < 2 ]]; then
		echo "Commit can not be empty"
		echo "Usage: gcmm-xxx commit1 commit2 commit3 ..."
		return
	fi
	typ=$1
	
	# if [[ $emoji == false ]] ; then
	# 	typ=${typ%?}
	# fi

	shift 1

	if [[ $uname == false ]] ; then
		final="$typ"
	else
		local gname=$(git_current_user_name)
		final="【$gname】$typ"
	fi

	# only one comment
	if [[ $# == 1 ]]; then
		# echo "git commit -m \"$final $1\""
		git commit -m "$final $1"
		return
	fi

	# more than one comment
	for (( i = 1; $# > 0; i++ )); do
		final="$final $i.$1;"
		shift 1
	done

	final="${final%?}."
	# echo "git commit -m \"$final\""
	git commit -m "$final"
}

gcmm-add()     { _std_commit "Add:" $@     }
gcmm-drop()     { _std_commit "Drop:" $@     }
gcmm-fix()      { _std_commit "Fix:" $@      }
gcmm-docs()     { _std_commit "Document:" $@     }
gcmm-revert()    { _std_commit "Revert:" $@    }
gcmm-make()    { _std_commit "Make:" $@    }
gcmm-optimize()     { _std_commit "Optimize:" $@     }
gcmm-refactor() { _std_commit "Refactor:" $@ }
gcmm-reformat() { _std_commit "Reformat:" $@ }
gcmm-rearrange() { _std_commit "Rearrange:" $@ }
gcmm-style()    { _std_commit "Style:" $@    }
gcmm-test()     { _std_commit "Test:" $@     }

gcmm-tmp(){
	if [[ $# == 0 ]]; then
		_std_commit "Tmp:🈳" "临时提交"
		return
	fi
	_std_commit "Tmp:🈳" $@
}
