= module PTY

#@#Author: 伊藤彰則

疑似端末(Pseudo tTY)を扱うモジュールです。

== Module Functions

--- getpty(command)
--- spawn(command)
#@todo

この関数は，仮想ttyを確保し，指定されたコマンドをその仮想tty
の向こうで実行し，配列を返します．戻り値は3つの要素からなる
配列です．最初の要素は仮想ttyから読み出すためのIOオブジェクト，
2番目は書きこむためのIOオブジェクト，3番目は子プロセスのプロ
セスIDです．この関数がイテレータとして呼ばれた場合，これらの
要素はブロックパラメータとして渡され，関数自体はnilを返します．

この関数によって作られたサブプロセスが動いている間，子プロセス
の状態を監視するために SIGCHLD シグナルを捕捉します．子プロセス
が終了したり停止した場合には，例外[[c:PTY::ChildExited]]が発生します．この間，すべての
SIGCHLD が PTY モジュールのシグナルハンドラに捕捉されるので，
サブプロセスを生成する他の関数(system() とか IO.popen()など)を
使うと，予期しない例外が発生することがあります．これを防ぐため
には，下記のprotect_signal()を参照してください．

この関数がブロックパラメータ付きで呼ばれた場合には，そのブロック
の中でのみ SIGCHLD が捕捉されます．したがって，ブロックパラメータ
として渡されたIOオブジェクトを，ブロックの外に持ち出して使うの
は勧められません．


--- protect_signal
#@todo

#@# These functions are obsolete in this version of pty. (see README)

この関数はイテレータです．ここで指定されたブロックの中では，
子プロセスが終了しても例外を発生しません．この関数を使うことで，
PTYの子プロセスが動いている間でも，system()や [[m:IO.popen]]などの
関数を安全に使うことができます．例えば，

  PTY.spawn("command_foo") do |r,w|
    ...
    ...
    PTY.protect_signal do
      system "some other commands"
    end
    ...
  end

このような記述により，"some other commands" が終了したときに
例外が発生するのを防げます．

--- reset_signal
#@todo

#@# These functions are obsolete in this version of pty. (see README)

PTY の子プロセスが動いていても，そのプロセスの終了時に例外が発生
しないようにします．

#@since 1.8.0
= class PTY::ChildExited

== Instance Methods

--- status
#@todo

子プロセスの終了ステータスを[[c:Process::Status]]オブジェクトで返します。
#@end

