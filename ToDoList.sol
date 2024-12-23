// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract TodoList {
    // Structure to store task details
    struct Task {
        uint id;
        string content;
        bool completed;
    }

    // Mapping to store tasks by their unique ID
    mapping(uint => Task) public tasks;
    uint public taskCount;

    // Event to trigger when a task is added
    event TaskCreated(uint id, string content, bool completed);

    // Event to trigger when a task is deleted
    event TaskDeleted(uint id);

    // Event to trigger when a task is marked as completed
    event TaskCompleted(uint id);

    // Constructor to initialize the task count
    constructor() {
        taskCount = 0;
    }

    // Function to add a task
    function createTask(string memory _content) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
    }

    // Function to delete a task
    function deleteTask(uint _taskId) public {
        require(_taskId > 0 && _taskId <= taskCount, "Task ID is invalid.");
        delete tasks[_taskId];
        emit TaskDeleted(_taskId);
    }

    // Function to mark a task as completed
    function completeTask(uint _taskId) public {
        require(_taskId > 0 && _taskId <= taskCount, "Task ID is invalid.");
        Task storage task = tasks[_taskId];
        task.completed = true;
        emit TaskCompleted(_taskId);
    }

    // Function to get a task's details
    function getTask(uint _taskId) public view returns (uint, string memory, bool) {
        require(_taskId > 0 && _taskId <= taskCount, "Task ID is invalid.");
        Task memory task = tasks[_taskId];
        return (task.id, task.content, task.completed);
    }

    // Function to get the total number of tasks
    function getAllTasksCount() public view returns (uint) {
        return taskCount;
    }
}
