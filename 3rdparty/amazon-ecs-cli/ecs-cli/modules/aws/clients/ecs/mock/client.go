// Copyright 2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License"). You may
// not use this file except in compliance with the License. A copy of the
// License is located at
//
//     http://aws.amazon.com/apache2.0/
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.

// Automatically generated by MockGen. DO NOT EDIT!
// Source: github.com/aws/amazon-ecs-cli/ecs-cli/modules/aws/clients/ecs (interfaces: ECSClient)

package mock_ecs

import (
	ecs0 "github.com/aws/amazon-ecs-cli/ecs-cli/modules/aws/clients/ecs"
	config "github.com/aws/amazon-ecs-cli/ecs-cli/modules/config"
	cache "github.com/aws/amazon-ecs-cli/ecs-cli/utils/cache"
	ecs "github.com/aws/aws-sdk-go/service/ecs"
	gomock "github.com/golang/mock/gomock"
)

// Mock of ECSClient interface
type MockECSClient struct {
	ctrl     *gomock.Controller
	recorder *_MockECSClientRecorder
}

// Recorder for MockECSClient (not exported)
type _MockECSClientRecorder struct {
	mock *MockECSClient
}

func NewMockECSClient(ctrl *gomock.Controller) *MockECSClient {
	mock := &MockECSClient{ctrl: ctrl}
	mock.recorder = &_MockECSClientRecorder{mock}
	return mock
}

func (_m *MockECSClient) EXPECT() *_MockECSClientRecorder {
	return _m.recorder
}

func (_m *MockECSClient) CreateCluster(_param0 string) (string, error) {
	ret := _m.ctrl.Call(_m, "CreateCluster", _param0)
	ret0, _ := ret[0].(string)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) CreateCluster(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "CreateCluster", arg0)
}

func (_m *MockECSClient) CreateService(_param0 string, _param1 string) error {
	ret := _m.ctrl.Call(_m, "CreateService", _param0, _param1)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) CreateService(arg0, arg1 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "CreateService", arg0, arg1)
}

func (_m *MockECSClient) DeleteCluster(_param0 string) (string, error) {
	ret := _m.ctrl.Call(_m, "DeleteCluster", _param0)
	ret0, _ := ret[0].(string)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) DeleteCluster(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "DeleteCluster", arg0)
}

func (_m *MockECSClient) DeleteService(_param0 string) error {
	ret := _m.ctrl.Call(_m, "DeleteService", _param0)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) DeleteService(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "DeleteService", arg0)
}

func (_m *MockECSClient) DescribeService(_param0 string) (*ecs.DescribeServicesOutput, error) {
	ret := _m.ctrl.Call(_m, "DescribeService", _param0)
	ret0, _ := ret[0].(*ecs.DescribeServicesOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) DescribeService(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "DescribeService", arg0)
}

func (_m *MockECSClient) DescribeTaskDefinition(_param0 string) (*ecs.TaskDefinition, error) {
	ret := _m.ctrl.Call(_m, "DescribeTaskDefinition", _param0)
	ret0, _ := ret[0].(*ecs.TaskDefinition)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) DescribeTaskDefinition(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "DescribeTaskDefinition", arg0)
}

func (_m *MockECSClient) DescribeTasks(_param0 []*string) ([]*ecs.Task, error) {
	ret := _m.ctrl.Call(_m, "DescribeTasks", _param0)
	ret0, _ := ret[0].([]*ecs.Task)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) DescribeTasks(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "DescribeTasks", arg0)
}

func (_m *MockECSClient) GetEC2InstanceIDs(_param0 []*string) (map[string]string, error) {
	ret := _m.ctrl.Call(_m, "GetEC2InstanceIDs", _param0)
	ret0, _ := ret[0].(map[string]string)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) GetEC2InstanceIDs(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "GetEC2InstanceIDs", arg0)
}

func (_m *MockECSClient) GetTasksPages(_param0 *ecs.ListTasksInput, _param1 ecs0.ProcessTasksAction) error {
	ret := _m.ctrl.Call(_m, "GetTasksPages", _param0, _param1)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) GetTasksPages(arg0, arg1 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "GetTasksPages", arg0, arg1)
}

func (_m *MockECSClient) Initialize(_param0 *config.CliParams) {
	_m.ctrl.Call(_m, "Initialize", _param0)
}

func (_mr *_MockECSClientRecorder) Initialize(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "Initialize", arg0)
}

func (_m *MockECSClient) IsActiveCluster(_param0 string) (bool, error) {
	ret := _m.ctrl.Call(_m, "IsActiveCluster", _param0)
	ret0, _ := ret[0].(bool)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) IsActiveCluster(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "IsActiveCluster", arg0)
}

func (_m *MockECSClient) RegisterTaskDefinition(_param0 *ecs.RegisterTaskDefinitionInput) (*ecs.TaskDefinition, error) {
	ret := _m.ctrl.Call(_m, "RegisterTaskDefinition", _param0)
	ret0, _ := ret[0].(*ecs.TaskDefinition)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) RegisterTaskDefinition(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "RegisterTaskDefinition", arg0)
}

func (_m *MockECSClient) RegisterTaskDefinitionIfNeeded(_param0 *ecs.RegisterTaskDefinitionInput, _param1 cache.Cache) (*ecs.TaskDefinition, error) {
	ret := _m.ctrl.Call(_m, "RegisterTaskDefinitionIfNeeded", _param0, _param1)
	ret0, _ := ret[0].(*ecs.TaskDefinition)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) RegisterTaskDefinitionIfNeeded(arg0, arg1 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "RegisterTaskDefinitionIfNeeded", arg0, arg1)
}

func (_m *MockECSClient) RunTask(_param0 string, _param1 string, _param2 int) (*ecs.RunTaskOutput, error) {
	ret := _m.ctrl.Call(_m, "RunTask", _param0, _param1, _param2)
	ret0, _ := ret[0].(*ecs.RunTaskOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) RunTask(arg0, arg1, arg2 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "RunTask", arg0, arg1, arg2)
}

func (_m *MockECSClient) RunTaskWithOverrides(_param0 string, _param1 string, _param2 int, _param3 map[string]string) (*ecs.RunTaskOutput, error) {
	ret := _m.ctrl.Call(_m, "RunTaskWithOverrides", _param0, _param1, _param2, _param3)
	ret0, _ := ret[0].(*ecs.RunTaskOutput)
	ret1, _ := ret[1].(error)
	return ret0, ret1
}

func (_mr *_MockECSClientRecorder) RunTaskWithOverrides(arg0, arg1, arg2, arg3 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "RunTaskWithOverrides", arg0, arg1, arg2, arg3)
}

func (_m *MockECSClient) StopTask(_param0 string) error {
	ret := _m.ctrl.Call(_m, "StopTask", _param0)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) StopTask(arg0 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "StopTask", arg0)
}

func (_m *MockECSClient) UpdateService(_param0 string, _param1 string, _param2 int64) error {
	ret := _m.ctrl.Call(_m, "UpdateService", _param0, _param1, _param2)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) UpdateService(arg0, arg1, arg2 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "UpdateService", arg0, arg1, arg2)
}

func (_m *MockECSClient) UpdateServiceCount(_param0 string, _param1 int64) error {
	ret := _m.ctrl.Call(_m, "UpdateServiceCount", _param0, _param1)
	ret0, _ := ret[0].(error)
	return ret0
}

func (_mr *_MockECSClientRecorder) UpdateServiceCount(arg0, arg1 interface{}) *gomock.Call {
	return _mr.mock.ctrl.RecordCall(_mr.mock, "UpdateServiceCount", arg0, arg1)
}
