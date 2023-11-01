@extends('layouts.layout')
@section('content')

<div class="wrapper todo-index">
    <h1>To-Do List</h1>
    <h3><a href="/create">Create a New Task</a>
    @foreach ($todos as $todo)
    <div class="todo-item">
        <img src="/img/todo.png" alt="pizza icon">
        <h4><a href="/{{$todo->id}}">Meeting Title: {{$todo->title}}</a></h4>
        <small></br>{{$todo->description}}</small>
    </div>
    @endforeach
</div>

@endsection