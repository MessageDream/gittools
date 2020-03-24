######## git commit easy cmd ########

# feat:     新功能（feature）
# fix:      修补bug
# docs:     文档（documentation）
# style:    格式（不影响代码运行的变动）
# refactor: 重构（即不是新增功能，也不是修改bug的代码变动）
# test:     增加测试
# chore:    构建过程或辅助工具的变动
# perf:     性能优化（performance）
# tmp:      临时提交

emoji=true

_std_commit() {
	if [[ $# < 2 ]]; then
		echo "Commit can not be empty"
		echo "Usage: gcmm-xxx commit1 commit2 commit3 ..."
		return
	fi
	typ=$1
	
	if [[ $emoji == false ]] ; then
		typ=${typ%?}
	fi

	shift 1

	local uname=$(git_current_user_name)
	final="$typ【$uname】"

	# only one comment
	if [[ $# == 1 ]]; then
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

gcmm-feat()     { _std_commit "feat:🎸" $@     }
gcmm-fix()      { _std_commit "fix:🐛" $@      }
gcmm-docs()     { _std_commit "docs:✏️" $@     }
gcmm-style()    { _std_commit "style:💄" $@    }
gcmm-refactor() { _std_commit "refactor:💡" $@ }
gcmm-test()     { _std_commit "test:💍" $@     }
gcmm-chore()    { _std_commit "chore:🤖" $@    }
gcmm-perf()     { _std_commit "perf:⚡️" $@     }
gcmm-tmp() {
	if [[ $# == 0 ]]; then
		_std_commit "tmp:🈳" "临时提交"
		return
	fi
	_std_commit "tmp:🈳" $@
}

