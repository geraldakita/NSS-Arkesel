<?php

namespace App\Http\Controllers;

use App\Models\todo;
use Illuminate\Http\Request;

class ToDoController extends Controller
{
    public function index(){
        $todo = todo::latest()->get();
        return view ('todo.index',[
            'todos' => $todo,
            ]);
    }

    public function show($id){
        $todo = todo::findOrFail($id);
        return view('todo.show', [
            'todo' => $todo,
            ]);
    }

    public function create(){
        return view('todo.create');
    }

    public function store(){
        $todo = new todo();
        $todo->name=request('name');
        $todo->title=request('title');
        $todo->description=request('description');
        $todo->save();
        return redirect('/');
    }

    public function destroy($id){
        $todo = todo::findOrFail($id);
        $todo->delete();
        return redirect('/');
    }
}
