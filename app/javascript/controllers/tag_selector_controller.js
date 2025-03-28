import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "selected", "hidden"]
  
  connect() {
    const tagIds = this.hiddenTarget.value
      .split(/[\s,]+/)
      .filter(id => id.length > 0)
      .map(id => id.toString())
    
    this.selectedTags = new Map()
    tagIds.forEach(id => {
      const name = this.getTagName(id)
      this.selectedTags.set(id, name)
    })
    
    this.updateDisplay()
  }
  
  select(event) {
    if (event.type === "change" || (event.type === "keydown" && event.key === "Enter")) {
      event.preventDefault()
      const select = this.inputTarget
      const id = select.value.toString()
      const name = this.getTagName(id)
      
      if (id && !this.selectedTags.has(id)) {
        this.selectedTags.set(id, name)
        this.updateDisplay()
      }
      select.value = ''
    }
  }
  
  remove(event) {
    const id = event.params.id.toString()
    const deleted = this.selectedTags.delete(id)
    this.updateDisplay()
  }
  
  updateDisplay() {
    const tagHtml = Array.from(this.selectedTags.entries())
      .map(([id, name]) => this.tagTemplate(id, name))
      .join('')
    
    this.selectedTarget.innerHTML = tagHtml
    this.hiddenTarget.value = Array.from(this.selectedTags.keys()).join(',')
  }
  
  getTagName(id) {
    const option = this.inputTarget.querySelector(`option[value="${id}"]`)
    return option ? option.textContent : id
  }
  
  tagTemplate(id, name) {
    return `
      <span class="tag" role="listitem">
        ${name}
        <button type="button" 
                data-action="click->tag-selector#remove" 
                data-tag-selector-id-param="${id}"
                class="tag-remove"
                aria-label="Remove ${name} tag">×</button>
      </span>
    `
  }
}
