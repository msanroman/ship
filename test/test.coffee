should = require 'should'
cmd = require '../lib/commands'
path = require 'path'
test_dir = path.join(process.cwd(), 'test')

describe 'commands', ->

  it 'should error when 0 args, no ship.conf', (done) ->
    process.chdir path.join(test_dir, 'no_ship_conf')

    cmd.default [], '', (err, res) ->
      err.should.match /specify a deployer/
      done()

  it 'should error when 0 args, ship.conf has multiple deployers', (done) ->
    process.chdir('../multiple_deployers')

    cmd.default [], '', (err, res) ->
      err.should.match /specify a deployer/
      done()

  it 'should succeed when 0 args, ship.conf w/ one deployer', (done) ->
    process.chdir('../one_deployer')

    cmd.default [], '', (err, res) ->
      should.not.exist(err)
      done()

  it 'should succeed when 1 arg which is a deployer name', (done) ->
    process.chdir('../')

    cmd.default ['s3'], '', (err, res) ->
      should.not.exist(err)
      done()

  it 'should error when 1 arg, path does not exist', (done) ->
    cmd.default ['/foo'], '', (err, res) ->
      err.should.match /specified a path to a folder/
      done()

  it 'should error when 1 arg, no ship.conf at path', (done) ->
    cmd.default ['no_ship_conf'], '', (err, res) ->
      err.should.match /specify a deployer/
      done()

  it 'should error when 1 arg, ship.conf at path w/ multiple deployers', (done) ->
    cmd.default ['multiple_deployers'], '', (err, res) ->
      err.should.match /specify a deployer/
      done()

  it 'should succeed when 1 arg, ship.conf at path w/ one deployer', (done) ->
    cmd.default ['one_deployer'], '', (err, res) ->
      should.not.exist(err)
      done()

  it 'should error when 2 args, path from 1st arg does not exist', (done) ->
    cmd.default ['/foo', 's3'], '', (err, res) ->
      err.should.match /specified a path to a folder/
      done()

  it 'should error when 2 args, deployer name from 2nd arg not found', (done) ->
    cmd.default ['one_deployer', 'foo'], '', (err, res) ->
      err.should.match /deployer in stock/
      done()