<?php
  require_once __DIR__ . "/../models/UserModel.php";

  class UserController extends BaseController
  {

    /**
     * ---- Create a function getList() of the current class UserController which extends class BaseController.
     */
    public function getList() {
      try {
        // ---- Create a new object of the class UserModel.
        $userModel = new UserModel();

        // ---- Limit a number of string parameters of the URL to 10. 
        $limit = 10;
        $urlParams = $this->getQueryStringParams();
        if (isset($urlParams['limit']) && is_numeric($urlParams['limit'])) {
          $limit = $urlParams['limit'];
        }

        // ---- Find parameter 'page ' in URL parameters, check of it's a positive number; set variable 'offset' using this parameter. 
        $offset = 0;
        $urlParams = $this->getQueryStringParams();
        if (isset($urlParams['page']) && is_numeric($urlParams['page']) && $urlParams['page'] > 0) {
          $offset = ($urlParams['page'] - 1) * $limit;
        }

        // ---- Call methode getAllUsers and give it 2 parameters which have been defined.
        $users = $userModel->getAllUsers($offset, $limit);

        // ---- Encode in json the result of the previous function
        $responseData = json_encode($users);

        // ---- Call a methode sendOutput of the parent class.
        $this->sendOutput($responseData);
      } catch (Error $e) {
        // ---- Treatment  of various errors
        $strErrorDesc = $e->getMessage().'Something went wrong! Please contact support.';
        $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        $this->sendOutput($strErrorDesc, ['Content-Type: application/json', $strErrorHeader]);
      }
    }

    /**
     * ---- Create a function get().
     */
    public function get() {
      try {
        // ---- Create a new object of the class UserModel.
        $userModel = new UserModel();

        // ---- Checking of parameters 'id' of the URL exists and is a number
        $urlParams = $this->getQueryStringParams();
        if (!isset($urlParams['id']) || !is_numeric($urlParams['id'])) {
          throw new Exception("L'identifiant est incorrect ou n'a pas été spécifié");
        }

        // ---- Call function getSingleUser of the class UserModel 
        $user = $userModel->getSingleUser($urlParams['id']);

        // ---- Encode in json the result of this function 
        $responseData = json_encode($user);

        // ---- Call function sendOutput and give it the encoded result as a parameter
        $this->sendOutput($responseData);
      } catch (Error $e) {
        // ---- Treatment of different errors
        $strErrorDesc = $e->getMessage().'Something went wrong! Please contact support.';
        $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        $this->sendOutput($strErrorDesc, ['Content-Type: application/json', $strErrorHeader]);
      }
    }

    /**
     * ---- Create a function store().
     */
    public function store() {
      try {
        // ---- Create a new object of class UserModel
        $userModel = new UserModel();

        // ---- Call function getBody() of the parent class
        $body = $this->getBody();
        if (!$body) {
          throw new Exception("Aucune donnée n'a été transmise dans le formulaire");
        }

        // ---- Check if the result of the function (body) contains name, phone, email, profil.
        if (!isset($body['nom'])) {
          throw new Exception("Aucun nom n'a été spécifié");
        }
        if (!isset($body['telephone'])) {
          throw new Exception("Aucun téléphone n'a été spécifié");
        }
        if (!isset($body['email'])) {
          throw new Exception("Aucun e-mail n'a été spécifié");
        }
        if (!isset($body['profil'])) {
          throw new Exception("Aucun profil n'a été spécifié");
        }

        // ---- Make a table of the user's parameters.
        $keys = array_keys($body);
        $valuesToInsert = [];
        foreach($keys as $key) {
          if (in_array($key, ['nom', 'telephone', 'email', 'profil'])) {
            $valuesToInsert[$key] = $body[$key];
          }
        }

        // ---- Call function insertUsers and give it a table with parameters for a new user.
        $user = $userModel->insertUser($valuesToInsert);

        // ---- Encode the result of the above function in json
        $responseData = json_encode($user);

        // ---- Call the function to send an API output. 
        $this->sendOutput($responseData);
      } catch (Error $e) {
        // ---- TODO : Commenter ce bout de code ----
        $strErrorDesc = $e->getMessage().'Something went wrong! Please contact support.';
        $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        $this->sendOutput($strErrorDesc, ['Content-Type: application/json', $strErrorHeader]);
      }
    }

    /**
     * ---- Create a function update().
     */
    public function update() {
      try {
        // ---- Create a new object of UserModel class.
        $userModel = new UserModel();

        // ---- Use function getBody() and check if it contains a data
        $body = $this->getBody();
        if (!$body) {
          throw new Exception("L'identifiant est incorrect ou n'a pas été spécifié");
        }

        // ---- Check if body contains parameter 'id'
        if (!isset($body['id'])) {
          throw new Exception("Aucun identifiant n'a été spécifié");
        }

        // ---- Create a table (an array list)
        $keys = array_keys($body);
        $valuesToUpdate = [];
        foreach($keys as $key) {
          if (in_array($key, ['nom', 'telephone', 'email', 'profil'])) {
            $valuesToUpdate[$key] = $body[$key];
          }
        }

        // ---- Call function updateUser and give it 'id' and new parameters to enter  
        $user = $userModel->updateUser($valuesToUpdate, $body['id']);

        // ---- Encode the result in json
        $responseData = json_encode($user);

        // ---- Send API output
        $this->sendOutput($responseData);
      } catch (Error $e) {
        // ---- Treat errors
        $strErrorDesc = $e->getMessage().'Something went wrong! Please contact support.';
        $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        $this->sendOutput($strErrorDesc, ['Content-Type: application/json', $strErrorHeader]);
      }
    }

    /**
     * ---- Create a function destroy().
     */
    public function destroy() {
      try {
        // ---- Create an object of the UserModel().
        $userModel = new UserModel();

        // ---- Get the URL parameters and check if it contains 'id' and it's a number
        $urlParams = $this->getQueryStringParams();
        if (!isset($urlParams['id']) || !is_numeric($urlParams['id'])) {
          throw new Exception("L'identifiant est incorrect ou n'a pas été spécifié");
        }

        // ---- Call function deleteUser and give it the 'id'
        $user = $userModel->deleteUser($urlParams['id']);

        // ---- Encode in json the result of this function
        $responseData = json_encode("L'utilisateur a été correctement supprimé");

        // ---- Send ASI output
        $this->sendOutput($responseData);
      } catch (Error $e) {
        // ---- Treat errors
        $strErrorDesc = $e->getMessage().'Something went wrong! Please contact support.';
        $strErrorHeader = 'HTTP/1.1 500 Internal Server Error';
        $this->sendOutput($strErrorDesc, ['Content-Type: application/json', $strErrorHeader]);
      }
    }

  }
