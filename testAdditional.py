import unittest
import os
import testLib

class TestLogin(testLib.RestTestCase):
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLoginUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password': 'password' })
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)

    def testLoginWrong(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'notthepassword'} )
        self.assertResponse(respData, count = None, errCode =
                testLib.RestTestCase.ERR_BAD_CREDENTIALS)
    def testLoginTwice(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password': 'password' })
        self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user1', 'password' : 'password'} )
        self.assertResponse(respData, count = 3)

    def testLoginBlank(self):
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : '', 'password' : 'hello'} )
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_CREDENTIALS)


class TestAdd(testLib.RestTestCase):
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAddTwice(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password': 'password' })
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password': 'password' })
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_USER_EXISTS)

    def testBadPass(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user1', 'password': '11charstring' * 13 })
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_PASSWORD)

    def testBadName(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'password' : 'user1', 'user': '11charstring' * 13 })
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAddBlankName(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password': '' })
        self.assertResponse(respData, count = None, errCode = testLib.RestTestCase.ERR_BAD_USERNAME)

    def testAddBlankPass(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'badmemory', 'password': '' })
        self.assertResponse(respData, count = 1, errCode = testLib.RestTestCase.SUCCESS)
