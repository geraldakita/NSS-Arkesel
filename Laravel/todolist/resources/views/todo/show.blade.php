@extends('layouts.layout')
@section('content')
<div class="wrapper todo-details">
    <h1>Task for {{$todo->name}}</h1>
    <p class="type">Title - {{$todo->title}}</p>
    <p class="base">Description - {{$todo->description}}</p>
    <p class="base">Created At - {{$todo->created_at}}</p>
    <form action="{{route('todo.destroy', $todo->id)}}" method="POST">
        @csrf
        @method('DELETE')
        <button>Complete Task</button>
    </form>
</div>
<a href="/" class = "back">Back to all tasks</a>
@endsection