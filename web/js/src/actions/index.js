import * as types from '../constants/ActionTypes'

let nextMessageId = 0

export const addPrompt = (message) => ({
  type: types.PROMPT,
  id: nextMessageId++,
  ...message
})

export const addError = (message) => ({
  type: types.ERROR,
  id: nextMessageId++,
  message
})

export const addCritical = (message) => ({
  type: types.ERROR,
  id: nextMessageId++,
  message
})

export const addInput = (command) => ({
  type: types.INPUT,
  command
})
